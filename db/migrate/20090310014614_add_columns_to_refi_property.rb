class AddColumnsToRefiProperty < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE  `refi_property` ADD COLUMN `net_change_in_tax_deduction_in_cents`  INT(11) NULL DEFAULT NULL  AFTER `keep_original_loans` , ADD COLUMN `pv_of_new_loans_at_old_wacc_in_cents` INT(11) NULL DEFAULT NULL  AFTER `net_change_in_tax_deduction_in_cents` ;"
  end

  def self.down
    execute "ALTER TABLE `refi_property` DROP COLUMN `net_change_in_tax_deduction_in_cents` , DROP COLUMN `pv_of_new_loans_at_old_wacc_in_cents` ;"
  end
end
