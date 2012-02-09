class Admin::BrokerUserController < AdminController
  active_scaffold :broker_user do |config|
    config.actions.exclude :delete, :show, :search
    list.sorting = {:email => :asc}
  end  
end
