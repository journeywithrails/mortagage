class UpdateTaxRate < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE `household_financial` DROP COLUMN `tax_filing_status_id`,
    DROP FOREIGN KEY `fk_household_financial_tax_filing_status`;"

    execute "ALTER TABLE `tax_rate` ADD COLUMN `tax_filing_status_id` INTEGER UNSIGNED NOT NULL AFTER `tax_pct`,
    ADD CONSTRAINT `FK_tax_rate_filing_status` FOREIGN KEY `FK_tax_rate_filing_status` (`tax_filing_status_id`)
    REFERENCES `tax_filing_status` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT;"

    execute "ALTER TABLE `tax_rate` ADD COLUMN `base_tax` INTEGER UNSIGNED NOT NULL AFTER `tax_filing_status_id`;"
  end

  def self.down
  end
end
