class AddColumnsToLoan < ActiveRecord::Migration
  def self.up
	execute "ALTER TABLE `loan` ADD COLUMN `commission_in_cents` int NULL DEFAULT NULL  AFTER `round_rates_up` , ADD COLUMN `open_date` DATE NULL  AFTER `commission_in_cents` ;"
  end

  def self.down
	execute "ALTER TABLE `loan` DROP COLUMN `commission_in_cents`, DROP COLUMN `open_date`;"
  end
end
