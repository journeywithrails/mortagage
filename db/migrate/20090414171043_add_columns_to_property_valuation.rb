class AddColumnsToPropertyValuation < ActiveRecord::Migration
  def self.up

    execute "ALTER TABLE `property_valuation` ADD COLUMN `bathrooms` INT(11) NULL DEFAULT NULL  AFTER `date` , ADD COLUMN `bedrooms` INT(11) NULL DEFAULT NULL  AFTER `date` , ADD COLUMN `finished_sq_ft` INT(11) NULL DEFAULT NULL  AFTER `date` , ADD COLUMN `last_sold_price_in_cents` INT(11) NULL DEFAULT NULL  AFTER `finished_sq_ft` , ADD COLUMN `lot_size_sq_ft` INT(11) NULL DEFAULT NULL  AFTER `date` , ADD COLUMN `tax_assessment_in_cents` INT(11) NULL DEFAULT NULL  AFTER `finished_sq_ft` , ADD COLUMN `tax_assessment_year` INT(11) NULL DEFAULT NULL  AFTER `tax_assessment_in_cents` , ADD COLUMN `year_built` INT(11) NULL DEFAULT NULL  AFTER `finished_sq_ft` ;"

  execute "ALTER TABLE `zillow_cache` ADD COLUMN `finished_sq_ft` VARCHAR(45) NULL DEFAULT NULL  AFTER `failed_to_match` ;"
  end

  def self.down


execute "ALTER TABLE `property_valuation` DROP COLUMN `bathrooms`, DROP COLUMN `bedrooms`, DROP COLUMN `finished_sq_ft`, DROP COLUMN `last_sold_price_in_cents`, DROP COLUMN `lot_size_sq_ft`, DROP COLUMN `tax_assessment_in_cents`, DROP COLUMN `tax_assessment_year`, DROP COLUMN `year_built`;"

execute "ALTER TABLE `zillow_cache` DROP COLUMN `finished_sq_ft`;"
  end
end
