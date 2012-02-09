class AddCollegeAndRetireValuesToRefiScenario < ActiveRecord::Migration
  def self.up

    execute "ALTER TABLE `refi_scenario` ADD COLUMN `value_of_college_savings_in_cents` INT(11) NULL DEFAULT NULL  AFTER `consolidate_debt_score` , ADD COLUMN `value_of_retirement_savings_in_cents` INT(11) NULL DEFAULT NULL  AFTER `consolidate_debt_score`"

  end

  def self.down    

    execute "ALTER TABLE `refi_scenario` DROP COLUMN `value_of_college_savings_in_cents`, DROP COLUMN `value_of_retirement_savings_in_cents`"
  end
end
