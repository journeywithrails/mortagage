class Admin::HistoricalRateController < AdminController
        
  active_scaffold :historical_rate do |config|
    config.actions = [:list, :nested]
    config.columns = [:interest_rate, :date, :rate]
    list.sorting = {:date => :desc}
    config.actions.exclude :create, :delete, :update, :show, :search
  end 
  
end
