class ClarifyViewHouseholdLoan < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE `view_household_loan` 
	      DROP COLUMN `exact_dob` ,
	      CHANGE COLUMN `available_equity` `available_equity_in_cents` INT(11) NULL DEFAULT NULL  ,
	      CHANGE COLUMN `purchase_price_in_cents` `purchase_price_in_cents` INT(11) NULL DEFAULT NULL  ,
	      CHANGE COLUMN `property_type` `property_type_id` INT(11) NULL DEFAULT NULL  ,
	      CHANGE COLUMN `occupancy_type` `occupancy_type_id` INT(11) NULL DEFAULT NULL  ,
	      CHANGE COLUMN `loan_size` `current_loan_amount_in_cents` INT(11) NULL DEFAULT NULL  ,
	      CHANGE COLUMN `ci_rate` `current_interest_rate` FLOAT NULL DEFAULT NULL  ,
	      CHANGE COLUMN `max_loan_to_value_percent` `loan_to_value_percent` FLOAT NULL DEFAULT NULL  ,
	      CHANGE COLUMN `paymant_savings` `payment_savings_in_cents` INT(11) NULL DEFAULT NULL  ,
	      CHANGE COLUMN `loan_date` `closing_date` DATE NULL DEFAULT NULL  ,
	      CHANGE COLUMN `next_arm_date` `next_arm_rate_adjustment_date` DATE NULL DEFAULT NULL  ,
	      CHANGE COLUMN `loan_type` `loan_type_id` INT(11) NULL DEFAULT NULL  ,
	      CHANGE COLUMN `monthly_hh_income` `monthly_hh_income_in_cents` INT(11) NULL DEFAULT NULL  ,
	      CHANGE COLUMN `consumer_debts` `consumer_debts_in_cents` INT(11) NULL DEFAULT NULL  ;"
  end

  def self.down
    execute "ALTER TABLE `view_household_loan`
	      ADD COLUMN `exact_dob` date default null,
	      CHANGE COLUMN  `available_equity_in_cents` `available_equity` INT(11) NULL DEFAULT NULL  ,
	      CHANGE COLUMN  `purchase_price_in_cents` `purchase_price_in_cents` INT(11) NULL DEFAULT NULL  ,
	      CHANGE COLUMN  `property_type_id` `property_type` VARCHAR(45) NULL DEFAULT NULL  ,
	      CHANGE COLUMN  `occupancy_type_id` `occupancy_type` VARCHAR(45) NULL DEFAULT NULL  ,
	      CHANGE COLUMN  `current_loan_amount_in_cents` `loan_size` INT(11) NULL DEFAULT NULL  ,
	      CHANGE COLUMN  `current_interest_rate` `ci_rate` FLOAT NULL DEFAULT NULL  ,
	      CHANGE COLUMN  `loan_to_value_percent` `max_loan_to_value_percent` FLOAT NULL DEFAULT NULL  ,
	      CHANGE COLUMN  `payment_savings_in_cents` `paymant_savings` INT(11) NULL DEFAULT NULL  ,
	      CHANGE COLUMN  `closing_date` `loan_date` DATE NULL DEFAULT NULL  ,
	      CHANGE COLUMN  `next_arm_rate_adjustment_date` `next_arm_date` DATE NULL DEFAULT NULL  ,
	      CHANGE COLUMN  `loan_type_id` `loan_type` VARCHAR(45) NULL DEFAULT NULL  ,
	      CHANGE COLUMN  `monthly_hh_income_in_cents` `monthly_hh_income` INT(11) NULL DEFAULT NULL  ,
	      CHANGE COLUMN  `consumer_debts_in_cents` `consumer_debts` INT(11) NULL DEFAULT NULL  ;"
  end
end
