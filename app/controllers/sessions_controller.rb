# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController  
  skip_before_filter :login_required, :except => :destroy

  def initialize
    super
    self.subtab_nav = "public"
  end  
  
  def new
  end

  def create
    begin
      self.current_user = User.authenticate(params[:email], params[:password])
      if logged_in?
        @current_account = self.current_user.account
        self.current_user.save_last_login 
        if params[:remember_me] == "1"
          self.current_user.remember_me
          cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
        end        
        redirect_back_or_default(root_url)
#        flash[:notice] = "Logged in successfully"       
      else
        flash.now[:error] = 'Invalid login credentials'
        render :action => 'new'
      end
    rescue ActiveRecord::RecordNotFound
      user = User.find_by_email(params[:email])
      if !user
        flash.now[:error] = 'Invalid login credentials'
        render :action => 'new'
      else
        redirect_to request.protocol + user.account.full_domain + ":" + request.port.to_s + '/sessions/new'
      end
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
  
  # from RailsKit - not using
#  def forgot
#    return unless request.post?
#    
#    if !params[:email].blank? && @user = current_account.users.find_by_email(params[:email])
#      PasswordReset.create(:user => @user, :remote_ip => request.remote_ip)
#      render :action => 'forgot_complete'
#    else
#      flash[:error] = "That account wasn't found."
#    end
#    
#  end
#  
#  def reset
#    raise ActiveRecord::RecordNotFound unless @password_reset = PasswordReset.find_by_token(params[:token])
#    raise ActiveRecord::RecordNotFound unless @password_reset.user.account == current_account
#    
#    @user = @password_reset.user
#    return unless request.post?
#    
#    if !params[:user][:password].blank? && 
#      if @user.update_attributes(:password => params[:user][:password],
#        :password_confirmation => params[:user][:password_confirmation])
#        @password_reset.destroy
#        flash[:notice] = "Your password has been updated.  Please log in with your new password."
#        redirect_to new_session_url
#      end
#    end
#  end  
end
