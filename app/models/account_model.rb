class AccountModel < ActiveRecord::Base
  self.abstract_class = true
  
  # gsub hack is here so we can use Broker models in migrations. Otherwise
  # migrations try to connect to broker_broker_development
  establish_connection("account_#{RAILS_ENV}".gsub('account_account','account'))
  
end
