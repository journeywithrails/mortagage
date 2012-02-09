class Admin::SubscriptionController < AdminController
   
  active_scaffold :subscription do |config|
    config.columns = [:account, :subscription_plan, :amount, :card_number, :card_expiration, :billing_id, :renewal_period, :next_renewal_at, :state, :user_limit, :created_at, :updated_at]
    list.sorting = {:account => :asc}
    config.actions.exclude :create, :delete, :update, :search
  end
  
end
