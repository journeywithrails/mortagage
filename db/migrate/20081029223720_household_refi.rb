class HouseholdRefi < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE `household` ADD COLUMN `refi_scenario_id` INTEGER,
ADD CONSTRAINT `FK_household_refi_scenario` FOREIGN KEY `FK_household_refi_scenario` (`refi_scenario_id`)
    REFERENCES `refi_scenario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;"

    execute "ALTER TABLE `refi_scenario` ADD COLUMN `refi_score` DECIMAL(5,2),
 ADD COLUMN `college_score` DECIMAL(5,2),
 ADD COLUMN `retirement_score` DECIMAL(5,2),
 ADD COLUMN `reduce_risk_score` DECIMAL(5,2),
 ADD COLUMN `consolidate_debt_score` DECIMAL(5,2);"
  end

  def self.down
  end
end
