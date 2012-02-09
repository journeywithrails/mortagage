class Admin::PropertyController < AdminController
  active_scaffold :property do |config|
    config.columns = [:loans, :household, :address1, :city, :state, :zip, :property_valuations]
    config.actions.exclude :create, :delete, :update
  end  
end
