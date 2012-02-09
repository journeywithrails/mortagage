class ImproveZillowCache < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE `zillow_cache` 
ADD COLUMN `bathrooms` VARCHAR(45) NULL DEFAULT NULL  AFTER `date_valued` , 
ADD COLUMN `bedrooms` VARCHAR(45) NULL DEFAULT NULL  AFTER `bathrooms` , 
ADD COLUMN `last_sold_date` VARCHAR(45) NULL DEFAULT NULL  AFTER `bedrooms` , 
ADD COLUMN `last_sold_price` VARCHAR(45) NULL DEFAULT NULL  AFTER `last_sold_date` , 
ADD COLUMN `lot_size_sq_ft` VARCHAR(45) NULL DEFAULT NULL  AFTER `date_valued` , 
ADD COLUMN `tax_assessment_year` VARCHAR(45) NULL DEFAULT NULL  AFTER `date_valued` , 
ADD COLUMN `tax_assessment` VARCHAR(45) NULL DEFAULT NULL  AFTER `tax_assessment_year` , 
ADD COLUMN `use_code` VARCHAR(45) NULL DEFAULT NULL  AFTER `date_valued` , 
ADD COLUMN `year_built` VARCHAR(45) NULL DEFAULT NULL  AFTER `tax_assessment` ;"
  end

  def self.down
  end
end
