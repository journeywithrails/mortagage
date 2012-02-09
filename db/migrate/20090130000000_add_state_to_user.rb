class AddStateToUser < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE `user` ADD `state` VARCHAR( 5 ) NULL AFTER `email`;"
  end

  def self.down
    execute "ALTER TABLE `user` DROP COLUMN `state`;"
  end
end
