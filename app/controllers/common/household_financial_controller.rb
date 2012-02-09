class Common::HouseholdFinancialController < ApplicationController
  def initialize
    super
    self.subtab_nav = 'new_loan'
  end
  
  active_scaffold
end
