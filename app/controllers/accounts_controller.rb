class AccountsController < ApplicationController
  include ModelControllerMethods
  
  before_filter :build_user, :only => [:new, :create]
  before_filter :build_plan, :only => [:new, :create]
  before_filter :load_billing, :only => [ :new, :create, :billing ]
  before_filter :load_subscription, :only => [ :billing, :plan ]
  before_filter :load_broker_servers, :only => [ :create ]
  before_filter :load_account, :only => [:edit, :update]
  skip_before_filter :active_account_required, :only => :canceled
  
  ssl_required :billing, :cancel, :new, :create
  ssl_allowed :plans, :thanks, :canceled
  
  def initialize
    super
    self.subtab_nav = "public"
  end
  
  # check/change subtab nav when authorization is checked (kind of a hack)
  def logged_in?
    tmp = super
    if tmp == false then self.subtab_nav = "public" else self.subtab_nav = "settings" end
    return tmp
  end
   
  def new
    # render :layout => 'public' # Uncomment if your "public" site has a different layout than the one used for logged-in users
  end
  
  def show
    redirect_to :action => :edit
  end
  
  def create
    if @account.needs_payment_info?
      @address.first_name = @creditcard.first_name
      @address.last_name = @creditcard.last_name
      @account.address = @address
      @account.creditcard = @creditcard
    end

    @account.broker_server_id = @broker_servers.rand.id

    begin
      @account.class.transaction do 
        @account.save!
        copy_to_broker_account
      end
      flash[:domain] = @account.domain
      self.current_user = @account.admin
      redirect_to "/"
    rescue
      render :action => 'new'
    end
  end

  def plans
    @plans = SubscriptionPlan.find(:all, :order => 'amount desc')
    if @plans.length == 1
      redirect_to :action => :new, :controller => :accounts, :plan => @plans[0].name
      return
    end
  end
  
  def billing
    if request.post?
      @address.first_name = @creditcard.first_name
      @address.last_name = @creditcard.last_name
      if @creditcard.valid? & @address.valid?
        if @subscription.store_card(@creditcard, :billing_address => @address.to_activemerchant, :ip => request.remote_ip)
          flash[:notice] = "Your billing information has been updated."
          redirect_to :action => "billing"
        end
      end
    end
  end

  def plan
    if request.post?
      @old_plan = @subscription.subscription_plan
      @plan = SubscriptionPlan.find(params[:plan_id])
      if @subscription.update_attributes(:plan => @plan)
        flash[:notice] = "Your subscription has been changed."
        SubscriptionNotifier.deliver_plan_changed(@subscription)
        redirect_to :action => "plan"
      else
        @subscription.plan = @old_plan
      end
    end
  end

  def cancel
    if request.post? and !params[:confirm].blank?
      current_account.cancel!
      self.current_user = nil
      reset_session
      redirect_to :action => "canceled"
    end
  end
  
  def thanks
    redirect_to :action => "plans" and return unless flash[:domain]
    # render :layout => 'public' # Uncomment if your "public" site has a different layout than the one used for logged-in users
  end
  
  def update
    begin
      @account.class.transaction do 
        @account.update_attributes!(params[:account])
        @user.update_attributes!(params[:user])
        flash[:notice] = "your account settings were saved."
        redirect_to :action => 'edit'
      end
    rescue
      flash[:notice] = $!.to_s
      render :action => 'edit'#, :layout => 'public' # Uncomment if your "public" site has a different layout than the one used for logged-in users
    end    
   end
  
  def dashboard
    render :text => 'Dashboard action, engage!', :layout => true
  end

  protected

    def copy_to_broker_account
      BrokerAccount.establish_connection("#{@account.broker_server.name}_#{RAILS_ENV}")
      broker_account = BrokerAccount.new(:name => @account.name)
      broker_account.id =  @account.id
      broker_account.save!
      
      BrokerUser.establish_connection("#{@account.broker_server.name}_#{RAILS_ENV}")
      broker_user = BrokerUser.new(:account_id=>broker_account.id, :email=>@user.email)
      broker_user.id = @user.id
      broker_user.save!
    end
  
    def load_object
      @obj = @account = current_account
    end
    
    def build_user
      @account.user = @user = User.new(params[:user])
    end
    
    def load_account
      @account = current_account    
      # rework this when we have a better multi-user UI perhaps
      @user = @account.admin
    end
    
    def build_plan
      redirect_to :action => "plans" unless @account.plan = @plan = SubscriptionPlan.find_by_name(params[:plan])
    end
    
    def redirect_url
      { :action => 'show' }
    end
    
    def load_billing
      @creditcard = ActiveMerchant::Billing::CreditCard.new(params[:creditcard])
      @address = SubscriptionAddress.new(params[:address])
    end

    def load_subscription
      @subscription = current_account.subscription
    end
    
    def authorized?
      %w(new create plans canceled thanks).include?(self.action_name) || 
      (self.action_name == 'dashboard' && logged_in?) ||
      admin?
    end 

    def load_broker_servers
      @broker_servers = BrokerServer.find(:all)
    end
end
