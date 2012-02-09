class Admin::SubscriptionPaymentController < AdminController
   
  active_scaffold :subscription_payment do |config|
    config.columns = [:subscription, :amount, :created_at]
    list.sorting = {:created_at => :asc}
    config.actions.exclude :search, :create
  end
  
end
