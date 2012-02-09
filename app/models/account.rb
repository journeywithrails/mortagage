class Account < AccountModel
  
  has_many :users, :dependent => :destroy
  has_one :admin, :class_name => "User", :conditions => { :admin => true }
  has_one :subscription, :dependent => :destroy
  has_many :subscription_payments
  belongs_to :broker_server
  
  file_column :logo_file,
    :magick => { :versions => {
      :thumb => {:crop=>"1:1", :size=>"50x50!"}, 
      :medium => {:crop=>"1:1", :size=>"200x200!"} } }
  
  validates_format_of :domain, :with => /\A[a-zA-Z0-9]+\Z/
  validate :valid_domain?
  validate_on_create :valid_user?
  validate_on_create :valid_plan?
  validate_on_create :valid_payment_info?
  validate_on_create :valid_subscription?
  
  attr_accessible :name, :domain, :user, :plan, :plan_start, :creditcard, :address, :website_url, 
    :logo_file, :delete_logo_file
  attr_accessor :user, :plan, :plan_start, :creditcard, :address, :delete_logo_file
  
  before_create :valid_subscription?
  after_create :create_admin
  after_create :send_welcome_email
  
  acts_as_paranoid
  
  Limits = {
    'user_limit' => Proc.new {|a| a.users.count }
  }
  
  Limits.each do |name, meth|
    define_method("reached_#{name}?") do
      return false unless self.subscription
      self.subscription.send(name) && self.subscription.send(name) <= meth.call(self)
    end
  end

  # need for file_column voodoo (from active_scaffold/lib/bridges/file_column.lib/file_column_helpers.rb)
  def delete_logo_file=(value)
    value = (value=="true") if String===value
    return unless value
    
    # passing nil to the file column causes the file to be deleted.  Don't delete if we just uploaded a file!
    self.logo_file = nil unless self.logo_file_just_uploaded?
  end
  
  def cancel!
    self.canceled = true
    self.save
  end

  def needs_payment_info?
    if new_record?
      AppConfig['require_payment_info_for_trials'] && @plan && @plan.amount > 0
    else
      self.subscription.needs_payment_info?
    end
  end
  
  # Does the account qualify for a particular subscription plan
  # based on the plan's limits
  def qualifies_for?(plan)
    Subscription::Limits.keys.collect {|rule| rule.call(self, plan) }.all?
  end
  
  def active?
    self.subscription.next_renewal_at >= Time.now
  end
  
  def domain
    @domain ||= self.full_domain.blank? ? '' : self.full_domain.split('.').first
  end
  
  def domain=(domain)
    @domain = domain
    self.full_domain = "#{domain}.#{AppConfig['base_domain']}"
  end
  
  protected
  
    def valid_domain?
      if self.full_domain.split('.').first.downcase == 'www'
        self.errors.add(:domain, 'is not available')
        return false
      end
      conditions = new_record? ? ['full_domain = ?', self.full_domain] : ['full_domain = ? and id <> ?', self.full_domain, self.id]
      self.errors.add(:domain, 'is not available') if self.full_domain.blank? || self.class.count(:conditions => conditions) > 0
    end
    
    # An account must have an associated user to be the administrator
    def valid_user?
      if !@user
        errors.add_to_base("Missing user information")
      elsif !@user.valid?
        @user.errors.full_messages.each do |err|
          errors.add_to_base(err)
        end
      end
    end
    
    def valid_payment_info?
      if needs_payment_info?
        unless @creditcard && @creditcard.valid?
          errors.add_to_base("Invalid payment information")
        end
        
        unless @address && @address.valid?
          errors.add_to_base("Invalid address")
        end
      end
    end
    
    def valid_plan?
      errors.add_to_base("Invalid plan selected.") unless @plan
    end
    
    def valid_subscription?
      return if errors.any? # Don't bother with a subscription if there are errors already
      self.build_subscription(:plan => @plan, :next_renewal_at => @plan_start, :creditcard => @creditcard, :address => @address)
      if !subscription.valid?
        errors.add_to_base("Error with payment: #{subscription.errors.full_messages.to_sentence}")
        return false
      end
    end
    
    def create_admin
      self.user.admin = true
      self.user.account = self
      self.user.save
    end
    
    def send_welcome_email
      SubscriptionNotifier.deliver_welcome(self)
    end
    
end
