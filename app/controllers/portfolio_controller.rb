class PortfolioController < ApplicationController  
  def initialize
    super
    self.subtab_nav = "portfolio"
  end
end
