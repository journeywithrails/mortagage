class AddUpdatedAtToLoan < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE `loan` ADD COLUMN `updated_at` DATETIME AFTER `calyx_record_id`;"
  end

  def self.down
    execute "ALTER TABLE `loan` DROP COLUMN `updated_at`;"
  end
end
