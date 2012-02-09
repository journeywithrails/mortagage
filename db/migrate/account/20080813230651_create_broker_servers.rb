class CreateBrokerServers < ActiveRecord::Migration
  def self.up
    create_table :broker_server do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :broker_server
  end
end
