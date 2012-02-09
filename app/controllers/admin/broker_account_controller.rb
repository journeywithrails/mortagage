class Admin::BrokerAccountController < AdminController
  active_scaffold :broker_account do |config|
    config.actions.exclude :delete, :show, :search
  end  
end
