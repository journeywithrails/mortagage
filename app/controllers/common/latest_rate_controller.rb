class Common::LatestRateController < ApplicationController
  active_scaffold :rate do |config|
    config.actions = [:list]
    config.list.columns = [:name, :latest_historical_rate]
    config.columns[:latest_historical_rate].sort = false
    config.columns[:name].sort = false
    config.columns[:name].clear_link
    columns[:latest_historical_rate].label = "rate"    
  end 
end
