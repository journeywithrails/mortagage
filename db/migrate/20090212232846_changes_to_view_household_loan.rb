class ChangesToViewHouseholdLoan < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE `view_household_loan` DROP COLUMN `max_dob` , DROP COLUMN `min_dob` , ADD COLUMN `age_years` INT(11) NULL DEFAULT NULL  AFTER `median_credit_score` , ADD COLUMN `original_loan_amount_in_cents` INT(11) NULL DEFAULT NULL  AFTER `median_credit_score` ;"
  end

  def self.down
    execute "ALTER TABLE `view_household_loan` ADD COLUMN `max_dob` DATE NULL , ADD COLUMN `min_dob` DATE NULL , DROP COLUMN `age_years` , DROP COLUMN `original_loan_amount_in_cents` ;"
  end
end
