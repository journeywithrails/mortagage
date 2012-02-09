class Admin::PropertyValuationController < AdminController

  active_scaffold :property_valuation do |config|
#    config.actions.exclude :create, :delete, :update, :show
  end   
end
