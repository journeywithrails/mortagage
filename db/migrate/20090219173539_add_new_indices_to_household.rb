class AddNewIndicesToHousehold < ActiveRecord::Migration
  def self.up

    execute "CREATE  TABLE IF NOT EXISTS `opportunity_type` (
	      `id` INT(11) NOT NULL ,
	      `name` VARCHAR(45) NULL DEFAULT NULL ,
	      PRIMARY KEY (`id`) )
	    ENGINE = InnoDB
	    DEFAULT CHARACTER SET = utf8
	    COLLATE = utf8_general_ci;"

    execute "INSERT INTO `opportunity_type` (`id`, `name`) VALUES (1, 'Refinance');"

    execute "INSERT INTO `opportunity_type` (`id`, `name`) VALUES (2, 'Debt Consolidation');"

    execute "INSERT INTO `opportunity_type` (`id`, `name`) VALUES (3, 'College Planning');"

    execute "INSERT INTO `opportunity_type` (`id`, `name`) VALUES (4, 'Retirement');"

    execute "INSERT INTO `opportunity_type` (`id`, `name`) VALUES (5, 'ARM Watch');"

    execute "ALTER TABLE household DROP FOREIGN KEY FK_household_refi_scenario;"

    execute "ALTER TABLE household DROP KEY FK_household_refi_scenario;"

    execute "ALTER TABLE `household` ADD COLUMN `arm_watch_mae_index` INT(11) NULL DEFAULT NULL , ADD COLUMN `college_mae_index` INT(11) NULL DEFAULT NULL , ADD COLUMN `consolidation_mae_index` INT(11) NULL DEFAULT NULL , ADD COLUMN `best_opportunity_type_id` INT(11) NULL DEFAULT NULL , ADD COLUMN `consolidation_refi_scenario_id` INT(11) NULL DEFAULT NULL , ADD COLUMN `college_refi_scenario_id` INT(11) NULL DEFAULT NULL , ADD COLUMN `retirement_refi_scenario_id` INT(11) NULL DEFAULT NULL , ADD COLUMN `arm_watch_refi_scenario_id` INT(11) NULL DEFAULT NULL , ADD COLUMN `best_refi_scenario_id` INT(11) NULL DEFAULT NULL , ADD COLUMN `refinance_mae_index` INT(11) NULL DEFAULT NULL , ADD COLUMN `retirement_mae_index` INT(11) NULL DEFAULT NULL , CHANGE COLUMN `mae_index` `best_mae_index` INT(11) NULL DEFAULT NULL  , CHANGE COLUMN `refi_scenario_id` `refinance_refi_scenario_id` INT(11) NULL DEFAULT NULL;"

    execute "ALTER TABLE `household` ADD CONSTRAINT `fk_household_opportunity_type` FOREIGN KEY (`best_opportunity_type_id` ) REFERENCES `opportunity_type` (`id` ) ON DELETE NO ACTION ON UPDATE NO ACTION;"

    execute "ALTER TABLE `household` ADD CONSTRAINT `fk_household_refi_scenario1` FOREIGN KEY (`refinance_refi_scenario_id` ) REFERENCES `refi_scenario` (`id` ) ON DELETE SET NULL ON UPDATE CASCADE;"

    execute "ALTER TABLE `household`  ADD CONSTRAINT `fk_household_refi_scenario2` FOREIGN KEY (`consolidation_refi_scenario_id` ) REFERENCES `refi_scenario` (`id` ) ON DELETE SET NULL ON UPDATE CASCADE;"

    execute "ALTER TABLE `household`  ADD CONSTRAINT `fk_household_refi_scenario3` FOREIGN KEY (`college_refi_scenario_id` ) REFERENCES `refi_scenario` (`id` ) ON DELETE SET NULL ON UPDATE CASCADE;"

    execute "ALTER TABLE `household`  ADD CONSTRAINT `fk_household_refi_scenario4` FOREIGN KEY (`retirement_refi_scenario_id` ) REFERENCES `refi_scenario` (`id` ) ON DELETE SET NULL ON UPDATE CASCADE;"

    execute "ALTER TABLE `household`  ADD CONSTRAINT `fk_household_refi_scenario5` FOREIGN KEY (`arm_watch_refi_scenario_id` ) REFERENCES `refi_scenario` (`id` ) ON DELETE SET NULL ON UPDATE CASCADE;"

    execute "ALTER TABLE `household`  ADD CONSTRAINT `fk_household_refi_scenario` FOREIGN KEY (`best_refi_scenario_id` ) REFERENCES `refi_scenario` (`id` ) ON DELETE SET NULL ON UPDATE CASCADE;"

    execute "ALTER TABLE `household`  ADD INDEX fk_household_opportunity_type (`best_opportunity_type_id` ASC) , ADD INDEX fk_household_refi_scenario1 (`refinance_refi_scenario_id` ASC) , ADD INDEX fk_household_refi_scenario2 (`consolidation_refi_scenario_id` ASC) , ADD INDEX fk_household_refi_scenario3 (`college_refi_scenario_id` ASC) , ADD INDEX fk_household_refi_scenario4 (`retirement_refi_scenario_id` ASC) , ADD INDEX fk_household_refi_scenario5 (`arm_watch_refi_scenario_id` ASC) ;"
  end

  def self.down


    execute "ALTER TABLE `household` DROP FOREIGN KEY `fk_household_refi_scenario`, DROP FOREIGN KEY `fk_household_refi_scenario1`, DROP FOREIGN KEY `fk_household_opportunity_type`, DROP FOREIGN KEY `fk_household_refi_scenario2`, DROP FOREIGN KEY `fk_household_refi_scenario3`, DROP FOREIGN KEY `fk_household_refi_scenario4`, DROP FOREIGN KEY `fk_household_refi_scenario5`,  DROP KEY `fk_household_refi_scenario`, DROP KEY `fk_household_refi_scenario1`, DROP KEY `fk_household_opportunity_type`, DROP KEY `fk_household_refi_scenario2`, DROP KEY `fk_household_refi_scenario3`, DROP KEY `fk_household_refi_scenario4`, DROP KEY `fk_household_refi_scenario5`;"

    execute "ALTER TABLE `household` DROP COLUMN `arm_watch_mae_index`, DROP COLUMN `college_mae_index`, DROP COLUMN `consolidation_mae_index`, DROP COLUMN `best_opportunity_type_id`, DROP COLUMN `consolidation_refi_scenario_id`, DROP COLUMN `college_refi_scenario_id`, DROP COLUMN `retirement_refi_scenario_id`, DROP COLUMN `arm_watch_refi_scenario_id`, DROP COLUMN `best_refi_scenario_id`, DROP COLUMN `refinance_mae_index`, DROP COLUMN `retirement_mae_index`, CHANGE COLUMN `best_mae_index` `mae_index` INT(11) NULL DEFAULT NULL  , CHANGE COLUMN `refinance_refi_scenario_id` `refi_scenario_id` INT(11) NULL DEFAULT NULL;"

    execute "ALTER TABLE `household` ADD CONSTRAINT `FK_household_refi_scenario`  FOREIGN KEY (`refi_scenario_id` )  REFERENCES `refi_scenario` (`id` )  ON DELETE SET NULL  ON UPDATE CASCADE , ADD INDEX FK_household_refi_scenario (`refi_scenario_id` ASC) ;"

    execute "DROP TABLE `opportunity_type`;"

  end
end
