class Admin::RateController < AdminController
    
  active_scaffold :rate do |config|
    config.columns.exclude :loans
    config.actions.exclude :create, :delete, :update, :search
  end 
end
