class AccountOptions < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE `account` 
  ADD COLUMN `logo_file` VARCHAR(255) AFTER `broker_server_id`,
  ADD COLUMN `website_url` VARCHAR(255) AFTER `logo_file`;"
  
    execute "alter table `user`
    add column `address1` varchar(255),
    add column `address2` varchar(255),
    add column `city` varchar(45),
    add column `state` varchar(5),
    add column `zip` varchar(15),
    add column `phone_work` varchar(15),
    add column `phone_mobile` varchar(15),
    add column `fax` varchar(15),
    add column `photo_file` varchar(255);"
  end

  def self.down
    remove_column(:account, :logo_file, :website_url)
    remove_column(:user, :address1, :address2, :city, :state, :zip, :phone_work, :phone_mobile, :fax, :photo_file)
  end
end
