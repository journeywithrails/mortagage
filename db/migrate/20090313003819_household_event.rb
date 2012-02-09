class HouseholdEvent < ActiveRecord::Migration
  def self.up

    execute "CREATE  TABLE IF NOT EXISTS `household_event` (
	      `id` INT(11) NOT NULL AUTO_INCREMENT ,
	      `account_id` INT(11) UNSIGNED NOT NULL ,
	      `household_id` INT(11) NOT NULL ,
	      `date` DATE NOT NULL ,
	      `message` VARCHAR(200) NOT NULL ,
	      `is_dismissed` TINYINT NOT NULL ,
	      PRIMARY KEY (`id`) ,
	      INDEX fk_household_alert_account (`account_id` ASC) ,
	      INDEX fk_household_alert_household (`household_id` ASC) ,
	      UNIQUE INDEX uniqueness (`account_id` ASC, `household_id` ASC, `date` ASC, `message` ASC) ,
	      CONSTRAINT `fk_household_alert_account`
	      FOREIGN KEY (`account_id` )
	      REFERENCES `broker`.`account` (`id` )
	      ON DELETE CASCADE
	      ON UPDATE CASCADE,
	      CONSTRAINT `fk_household_alert_household`
	      FOREIGN KEY (`household_id` )
	      REFERENCES `broker`.`household` (`id` )
	      ON DELETE CASCADE
	      ON UPDATE CASCADE)
	      ENGINE = InnoDB
	      DEFAULT CHARACTER SET = utf8
	      COLLATE = utf8_general_ci;"
  end

  def self.down
      execute "alter table household_event drop foreign key fk_household_alert_account;"
      execute "alter table household_event drop index fk_household_alert_account;"		
      execute "alter table household_event drop foreign key fk_household_alert_account;"
      execute "alter table household_event drop index fk_household_alert_account;"		
      execute "drop `household_event`"	
  end
end
