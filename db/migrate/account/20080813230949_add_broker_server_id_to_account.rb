class AddBrokerServerIdToAccount < ActiveRecord::Migration
  def self.up
    add_column :account, :broker_server_id, :integer, :options => "constraint fk_account_broker_server references broker_server(id)"
  end

  def self.down
    remove_column :account, :broker_server_id
  end
end
