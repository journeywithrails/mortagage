class FixNameOfCollegePlanningFk < ActiveRecord::Migration
  def self.up

    execute "ALTER TABLE  `college_planning_values` DROP FOREIGN KEY `fk_college_planning_values_other_opportunity_values`;"
    execute "ALTER TABLE  `college_planning_values` DROP KEY `fk_college_planning_values_other_opportunity_values`;"
    execute "ALTER TABLE `college_planning_values` CHANGE COLUMN `cost_of_public_in_state_college_in_cents` `other_opportunity_values_id` INT(11) NULL DEFAULT NULL;"

    execute "ALTER TABLE  `college_planning_values` ADD CONSTRAINT `fk_college_planning_values_other_opportunity_values`
	FOREIGN KEY (`other_opportunity_values_id` )
	REFERENCES `other_opportunity_values` (`id` )
	ON DELETE CASCADE
	ON UPDATE NO ACTION;"

    execute "ALTER TABLE `college_planning_values` ADD COLUMN `cost_of_public_in_state_college_in_cents` INT(11) NULL DEFAULT NULL  AFTER `funds_needed_for_public_out_of_state_college_in_cents` ;"

  end

  def self.down


    execute "ALTER TABLE  `college_planning_values` DROP FOREIGN KEY `fk_college_planning_values_other_opportunity_values`;"
    execute "ALTER TABLE `college_planning_values` DROP COLUMN `cost_of_public_in_state_college_in_cents` ;"
    execute "ALTER TABLE `college_planning_values` CHANGE COLUMN `other_opportunity_values_id` `cost_of_public_in_state_college_in_cents`  INT(11) NULL DEFAULT NULL;"

    execute "ALTER TABLE  `college_planning_values` ADD CONSTRAINT `fk_college_planning_values_other_opportunity_values`
    FOREIGN KEY (`cost_of_public_in_state_college_in_cents` )
    REFERENCES `other_opportunity_values` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION;"

  end
end
