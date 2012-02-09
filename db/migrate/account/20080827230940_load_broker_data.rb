require 'active_record/fixtures'

ActiveRecord::Base.pluralize_table_names = false

class LoadBrokerData < ActiveRecord::Migration
  def self.up
    down
    directory = "#{File.dirname(__FILE__)}/../dev_data"
    Fixtures.create_fixtures(directory, "broker_server")
    execute "update account set broker_server_id=1"
  end

  def self.down
    Account.all.each { |a| a.broker_server_id = nil && a.save }
    execute "delete from account.broker_server"
  end
end
