class AdminController < ApplicationController  
  def initialize
    super
    self.subtab_nav = "admin"
  end
end
