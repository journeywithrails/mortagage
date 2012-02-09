# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include SslRequirement

  before_filter :redirect_to_account_domain
  before_filter :login_required
  before_filter :configure_broker_db

  before_filter :active_account_required

  # helper :all # include all helpers, all the time

  # make these methods available in the view
  helper_method :current_account, :admin?, :current_broker_user

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '779a6e2f0fe7736f0a73da4a7d9f13d4'

  filter_parameter_logging :password, :creditcard

  attr_writer :subtab_nav

  def subtab_nav
    @subtab_nav || controller_name
  end
    

  protected

  def redirect_to_account_domain
    if session[:user_id]
      user = User.find(session[:user_id], :include => :account)
      redirect_to "http://#{user.account.full_domain}:#{request.port}" if request.host != user.account.full_domain
    end
  end

  def active_account_required
    begin
      redirect_to :controller => :account, :action => :canceled if current_account.canceled
    rescue ActiveRecord::RecordNotFound
    end
  end

  def current_account
    logger.debug "looking for domain #{request.host}"    
    @current_account ||= Account.find_by_full_domain(request.host)
    raise ActiveRecord::RecordNotFound unless @current_account
    @current_account
  end

  def admin?
    logged_in? && current_user.admin?
  end
  
  def current_server
    @current_server ||= Server.current
    raise ActiveRecord::RecordNotFound unless @current_server
    @current_server
  end

  def configure_broker_db
    ActiveRecord::Base.establish_connection "#{@current_account.broker_server.name}_#{RAILS_ENV}" if @current_account
  end
    
  def current_broker_user
    @broker_user ||= BrokerUser.find(current_user.id)
  end
end
