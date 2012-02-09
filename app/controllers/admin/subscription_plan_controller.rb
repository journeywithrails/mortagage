class Admin::SubscriptionPlanController < AdminController
    
  active_scaffold :subscription_plan do |config|
    config.columns = [:name, :amount, :renewal_period, :user_limit, :created_at, :updated_at]
    list.sorting = {:name => :asc}
#    config.actions.exclude :create, :delete, :update, :show
  end
  
end
