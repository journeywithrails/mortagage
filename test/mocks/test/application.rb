require 'controllers/application'

class ApplicationController < ActionController::Base 
  def ssl_required? 
    false 
  end 
end