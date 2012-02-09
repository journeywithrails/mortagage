class UsersController < ApplicationController
  
  include ModelControllerMethods
  
  before_filter :check_user_limit, :only => :create
  skip_before_filter :login_required

  def initialize
    super
    self.subtab_nav = "public"
  end   
  
  def forgot_password
    return unless params[:user] && params[:user][:email]
    if params[:user][:email]
      user = User.find_by_email(params[:user][:email])
      if !user
        flash[:error] = 'A user with that email address does not exist.'
        return
      end
      password = user.reset_password
      SubscriptionNotifier.deliver_reset_password(params[:user][:email], password)
      flash[:notice] = 'An email with your new password has been sent.'
      redirect_to new_session_url
    end
  end

  protected
  
    def scoper
      current_account.users
    end
    
    def authorized?
      self.action_name == 'index' || admin?
    end
    
    def check_user_limit
      redirect_to new_user_url if current_account.reached_user_limit?
    end

end
