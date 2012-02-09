class HomeController < ApplicationController
  skip_before_filter :login_required, :except => :welcome
 
  def initialize
    super
    self.subtab_nav = "public"
  end
  
  # public 
  
  def services
  end
  
  def pricing
  end
  
  def tour
  end
  
  def security
  end
  
  def about_us
  end
  
  def index
    if logged_in?
      self.subtab_nav = "blank"
      render :action => :welcome
    else 
      redirect_to "/index.html"
    end
  end

  # logged_in
  
  def welcome
  end
end
