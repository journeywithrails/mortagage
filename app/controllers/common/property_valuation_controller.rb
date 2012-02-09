class Common::PropertyValuationController < ApplicationController

  active_scaffold :property_valuation do |config|
    config.actions.exclude :delete, :show, :search
  end   
end
