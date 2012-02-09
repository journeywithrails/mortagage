require File.dirname(__FILE__) + '/../spec_helper'
include ActiveMerchant::Billing

describe AccountsController do
  before(:each) do
    controller.stubs(:current_account).returns(@account = accounts(:localhost))
  end
  
  it 'should create a new account' do
    @user = User.new(user_params = 
      { 'login' => 'foo', 'email' => 'foo@foo.com',
        'password' => 'password', 'password_confirmation' => 'password' })
    @account = Account.new(acct_params = 
      { 'name' => 'Bob', 'domain' => 'Bob' })
    User.expects(:new).with(user_params).returns(@user)
    Account.expects(:new).with(acct_params).returns(@account)
    @account.expects(:user=).with(@user)
    @account.expects(:save).returns(true)
    
    post :create, :account => acct_params, :user => user_params, :plan => subscription_plans(:basic).name
    response.should redirect_to(thanks_url)
    flash[:domain].should == @account.domain
  end
  
  it "should list plans with the most expensive first" do
    get :plans
    assigns(:plans).should == SubscriptionPlan.find(:all, :order => 'amount desc')
  end
  
  describe "loading the account creation page" do
    before(:each) do
      @plan = subscription_plans(:basic)
      get :new, :plan => @plan.name
    end
    
    it "should load the plan by name" do
      assigns(:plan).should == @plan
    end
    
    it "should prep payment and address info" do
      assigns(:creditcard).should_not be_nil
      assigns(:address).should_not be_nil
    end
  end
  
  describe 'updating an existing account' do
    it 'should prevent a non-admin from updating' do
      controller.stubs(:current_user).returns(users(:aaron))
      put :update, :account => { :name => 'Foo' }
      response.should redirect_to(new_session_url)
    end
    
    it 'should allow an admin to update' do
      controller.stubs(:current_user).returns(users(:quentin))
      @account.expects(:update_attributes).with('name' => 'Foo').returns(true)
      put :update, :account => { :name => 'Foo' }
      response.should redirect_to(account_url)
    end
  end
  
  
  describe "updating billing info" do
    before(:each) do
      controller.stubs(:current_user).returns(@account.admin)
      CreditCard.stubs(:new).returns(@card = mock('CreditCard', :valid? => true, :first_name => 'Bo', :last_name => 'Peep'))
      SubscriptionAddress.stubs(:new).returns(@address = mock('SubscriptionAddress', :valid? => true, :to_activemerchant => 'foo'))
    end
    
    it "should store the card when it and the address are valid" do
      @address.expects(:first_name=).with('Bo')
      @address.expects(:last_name=).with('Peep')
      @account.subscription.expects(:store_card).with(@card, :billing_address => 'foo', :ip => '0.0.0.0').returns(true)
      post :billing, :creditcard => {}, :address => {}      
    end
  end
  
  describe "when canceling" do
    before(:each) do
      controller.stubs(:current_user).returns(users(:quentin))
    end
    
    it "should not destroy the account without confirmation" do
      @account.expects(:destroy).never
      post :cancel
      response.should render_template('cancel')
    end
    
    it "should destroy the account" do
      @account.expects(:destroy).returns(true)
      post :cancel, :confirm => 1
      response.should redirect_to('/account/canceled')
    end

    it "should log out the user" do
      @account.stubs(:destroy).returns(true)
      controller.expects(:current_user=).with(nil)
      post :cancel, :confirm => 1
    end
  end
end
