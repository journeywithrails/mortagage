class AddRefinanceTables < ActiveRecord::Migration
  def self.up

# contains sql migrations 19(b), 20, and 21

execute "SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;"
execute "SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;"
execute "SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';"

execute "CREATE  TABLE IF NOT EXISTS `refi_loan` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `loan_rank` INT(11) NULL DEFAULT NULL ,
  `refi_property_id` INT(11) NULL DEFAULT NULL ,
  `loan_type_id` INT(10) NULL DEFAULT NULL ,
  `loan_amount_in_cents` INT(11) NULL DEFAULT NULL ,
  `note_rate` FLOAT NULL ,
  `monthly_payment_in_cents` INT(11) NULL DEFAULT NULL ,
  `first_year_interest_in_cents` INT(11) NULL DEFAULT NULL ,
  `loan_term` INT(11) NULL DEFAULT NULL ,
  `estimated_payoff_date` DATE NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_refi_loan_refi_property (`refi_property_id` ASC) ,
  INDEX fk_refi_loan_loan_type (`loan_type_id` ASC) ,
  CONSTRAINT `fk_refi_loan_refi_property`
    FOREIGN KEY (`refi_property_id` )
    REFERENCES `refi_property` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_refi_loan_loan_type`
    FOREIGN KEY (`loan_type_id` )
    REFERENCES `loan_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;"

execute "CREATE  TABLE IF NOT EXISTS `refi_property` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `refi_scenario_id` INT(11) NULL DEFAULT NULL ,
  `property_id` INT(11) NULL DEFAULT NULL ,
  `property_valuation_id` INT(11) NULL DEFAULT NULL ,
  `is_interest_deductible` BIT NULL ,
  `is_pmi_deductible` BIT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_refi_property_refi_scenario (`refi_scenario_id` ASC) ,
  INDEX fk_refi_property_property (`property_id` ASC) ,
  INDEX fk_refi_property_property_valuation (`property_valuation_id` ASC) ,
  INDEX ix_property_id (`property_id` ASC) ,
  INDEX ix_refi_scenario_id (`refi_scenario_id` ASC) ,
  CONSTRAINT `fk_refi_property_refi_scenario`
    FOREIGN KEY (`refi_scenario_id` )
    REFERENCES `refi_scenario` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_refi_property_property`
    FOREIGN KEY (`property_id` )
    REFERENCES `property` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_refi_property_property_valuation`
    FOREIGN KEY (`property_valuation_id` )
    REFERENCES `property_valuation` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;"

execute "CREATE  TABLE IF NOT EXISTS `refi_scenario` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `date_calculated` DATETIME NULL DEFAULT NULL ,
  `household_id` INT(11) NULL DEFAULT NULL ,
  `is_present_situation` BIT NULL ,
  `total_monthly_payment_in_cents` INT(11) NULL DEFAULT NULL ,
  `total_loan_value_in_cents` INT(11) NULL DEFAULT NULL ,
  `total_equity_in_cents` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_refi_scenario_household (`household_id` ASC) ,
  INDEX ix_hh_id (`household_id` ASC) ,
  CONSTRAINT `fk_refi_scenario_household`
    FOREIGN KEY (`household_id` )
    REFERENCES `household` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;"

execute "ALTER TABLE `refi_scenario` DROP COLUMN `is_present_situation` , 
ADD COLUMN `is_base_case` BOOLEAN NULL  AFTER `household_id` , 
ADD COLUMN `net_change_in_tax_deduction` INT(11) NULL DEFAULT NULL  AFTER `total_equity_in_cents` , 
ADD COLUMN `net_monthly_payment_change_in_cents` INT(11) NULL DEFAULT NULL  AFTER `total_equity_in_cents` , 
ADD COLUMN `total_cash_out_in_cents` INT(11) NULL DEFAULT NULL  AFTER `net_monthly_payment_change_in_cents` , 
ADD COLUMN `total_tax_deduction_in_cents` INT(11) NULL DEFAULT NULL  AFTER `total_equity_in_cents` , 
CHANGE COLUMN `total_monthly_payment_in_cents` `total_monthly_payment_in_cents` INT(11) NULL DEFAULT NULL  AFTER `total_loan_value_in_cents` ;"

execute "ALTER TABLE `refi_property` ADD COLUMN `keep_original_loans` BOOLEAN NULL  AFTER `is_pmi_deductible` , 
ADD COLUMN `monthly_pmi_in_cents` INT(11) NULL DEFAULT NULL  AFTER `is_pmi_deductible` , 
CHANGE COLUMN `is_interest_deductible` `is_primary_residence` BOOLEAN NULL  , 
CHANGE COLUMN `is_pmi_deductible` `is_pmi_deductible` BOOLEAN NULL  ;"

execute "ALTER TABLE `refi_loan` CHANGE COLUMN `note_rate` `note_rate` FLOAT NULL  , 
CHANGE COLUMN `estimated_payoff_date` `estimated_payoff_date` DATE NULL  ;"

execute "SET SQL_MODE=@OLD_SQL_MODE;"
execute "SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;"
execute "SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;"

execute "CREATE  TABLE IF NOT EXISTS `property_use` (
  `id` INT(11) NOT NULL ,
  `name` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;"

execute "ALTER TABLE `loan` ADD COLUMN `has_pmi` BOOLEAN NULL  AFTER `loan_status_id` , ADD COLUMN `pmi_expires_ltv` FLOAT NULL  AFTER `has_pmi` , ADD COLUMN `pmi_expires` DATE NULL  AFTER `has_pmi` , ADD COLUMN `property_use_id` INT(11) NULL DEFAULT NULL  AFTER `loan_status_id` , ADD CONSTRAINT `fk_loan_property_use`
  FOREIGN KEY (`property_use_id` )
  REFERENCES `property_use` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION, ADD INDEX fk_loan_property_use (`property_use_id` ASC) ;"

execute "ALTER TABLE `property` ADD COLUMN `property_use_id` INT(11) NULL DEFAULT NULL  AFTER `estimated_tax_amt_in_cents` , 
CHANGE COLUMN `estimated_tax_amt_in_cents` `estimated_tax_amt_in_cents` INT(11) NULL DEFAULT NULL  , 
ADD CONSTRAINT `fk_property_property_use`
  FOREIGN KEY (`property_use_id` )
  REFERENCES `property_use` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION, ADD INDEX fk_property_property_use (`property_use_id` ASC) ;"

execute "ALTER TABLE `refi_property` CHANGE COLUMN `is_primary_residence` `is_primary_residence` BOOLEAN NULL  , 
CHANGE COLUMN `is_pmi_deductible` `is_pmi_deductible` BOOLEAN NULL  , 
CHANGE COLUMN `keep_original_loans` `keep_original_loans` BOOLEAN NULL  ;"

execute "ALTER TABLE `refi_loan` ADD COLUMN `rate_minus_1pt_monthly_payment_in_cents` INT(11) NULL DEFAULT NULL  AFTER `estimated_payoff_date` , 
ADD COLUMN `rate_plus_2pt_monthly_payment_in_cents` INT(11) NULL DEFAULT NULL  AFTER `rate_minus_1pt_monthly_payment_in_cents` , 
ADD COLUMN `rate_plus_4pt_monthly_payment_in_cents` INT(11) NULL DEFAULT NULL  AFTER `rate_plus_2pt_monthly_payment_in_cents` , 
ADD COLUMN `total_interest_in_cents` INT(11) NULL DEFAULT NULL  AFTER `rate_plus_4pt_monthly_payment_in_cents` , 
ADD COLUMN `total_interest_paid_in_cents` INT(11) NULL DEFAULT NULL  AFTER `rate_plus_4pt_monthly_payment_in_cents` , 
ADD COLUMN `total_principal_in_cents` INT(11) NULL DEFAULT NULL  AFTER `total_interest_in_cents` , 
ADD COLUMN `total_principal_paid_in_cents` INT(11) NULL DEFAULT NULL  AFTER `total_interest_paid_in_cents` , 
CHANGE COLUMN `note_rate` `note_rate` FLOAT NULL  , 
CHANGE COLUMN `first_year_interest_in_cents` `next_year_interest_in_cents` INT(11) NULL DEFAULT NULL  , 
CHANGE COLUMN `estimated_payoff_date` `estimated_payoff_date` DATE NULL  ;"

execute "ALTER TABLE `refi_scenario` ADD COLUMN `net_change_in_present_value_in_cents` INT(11) NULL DEFAULT NULL  AFTER `net_change_in_tax_deduction_in_cents` , 
ADD COLUMN `total_present_value_in_cents` INT(11) NULL DEFAULT NULL  AFTER `total_tax_deduction_in_cents` , 
CHANGE COLUMN `is_base_case` `is_base_case` BOOLEAN NULL  , 
CHANGE COLUMN `net_change_in_tax_deduction` `net_change_in_tax_deduction_in_cents` INT(11) NULL DEFAULT NULL"

execute "ALTER TABLE `refi_scenario`  ADD COLUMN `pv_of_new_loans_at_old_wacc_in_cents` INT(11) NULL DEFAULT NULL  AFTER `net_change_in_present_value_in_cents`"

execute "ALTER TABLE `loan` ADD COLUMN `disc_period_1` INT(11) NULL DEFAULT NULL  AFTER `pmi_expires_ltv` , 
ADD COLUMN `disc_period_2` INT(11) NULL DEFAULT NULL  AFTER `disc_period_1` , 
ADD COLUMN `disc_period_3` INT(11) NULL DEFAULT NULL  AFTER `disc_period_2` , 
ADD COLUMN `disc_period_4` INT(11) NULL DEFAULT NULL  AFTER `disc_period_3` , 
ADD COLUMN `disc_period_5` INT(11) NULL DEFAULT NULL  AFTER `disc_period_4` , 
ADD COLUMN `disc_rate_1` FLOAT NULL  AFTER `pmi_expires_ltv` , 
ADD COLUMN `disc_rate_2` FLOAT NULL  AFTER `disc_period_1` , 
ADD COLUMN `disc_rate_3` FLOAT NULL  AFTER `disc_period_2` , 
ADD COLUMN `disc_rate_4` FLOAT NULL  AFTER `disc_period_3` , 
ADD COLUMN `disc_rate_5` FLOAT NULL  AFTER `disc_period_4` , 
ADD COLUMN `loan_recast_period` INT(11) NULL DEFAULT NULL  AFTER `biweekly_payments` , 
ADD COLUMN `payment_adjustment_cap` FLOAT NULL  AFTER `biweekly_payments` , 
ADD COLUMN `round_rates_up` BOOLEAN NULL  AFTER `disc_period_5` , 
ADD COLUMN `rounding_increment` FLOAT NULL  AFTER `disc_period_5` , 
CHANGE COLUMN `payment_adjustment_period` `payment_adjustment_period` INT(11) NULL DEFAULT NULL  AFTER `biweekly_payments` , 
CHANGE COLUMN `adjustment_cap` `first_adjustment_cap` FLOAT NULL DEFAULT NULL  , CHANGE COLUMN `has_pmi` `has_pmi` BOOLEAN NULL  , 
CHANGE COLUMN `pmi_expires` `pmi_expires` DATE NULL  , 
CHANGE COLUMN `pmi_expires_ltv` `pmi_expires_ltv` FLOAT NULL"
  end

  def self.down
  end
end
