class Common::PropertyController < ApplicationController
  def initialize
    super
    self.subtab_nav = 'new_loan'
  end

  active_scaffold :property do |config|
    config.columns = [:loans, :household, :address1, :address2, :city, :state, :zip, :property_valuations]
    
    config.list.columns = [:loans, :household, :address1, :city, :state, :property_valuations]
    
    columns[:address1].label = "address"
#    columns[:address2].label = "address"

    columns[:property_valuations].label = "valuations"
    
    config.actions = [:list, :nested, :show]
  end  
end
