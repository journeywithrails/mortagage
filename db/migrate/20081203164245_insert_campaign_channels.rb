class InsertCampaignChannels < ActiveRecord::Migration
  def self.up
    execute "delete from campaign_channel"
    execute "ALTER TABLE `campaign_channel` MODIFY COLUMN `id` INTEGER UNSIGNED NOT NULL;"
    execute "insert ignore into campaign_channel (id, name) values (1, 'Email')"
    execute "insert ignore into campaign_channel (id, name) values (2, 'Postal Mail')"
  end

  def self.down
    execute "delete from campaign_channel"
    execute "ALTER TABLE `campaign_channel` MODIFY COLUMN `id` INTEGER UNSIGNED NOT NULL DEFAULT NULL AUTO_INCREMENT;"
  end
end
