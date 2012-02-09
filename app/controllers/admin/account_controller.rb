class Admin::AccountController < AdminController
  active_scaffold :account do |config|
    config.columns = [:name, :users, :broker_server, :logo_file, :website_url, :subscription, :subscription_payments, :canceled, :created_at]
    config.update.columns = [:name, :broker_server, :logo_file, :website_url, :canceled]
    list.sorting = {:name => :desc}
    config.actions.exclude  :show, :search, :create
  end
end
