class AddDependentTable < ActiveRecord::Migration
  def self.up
    execute "CREATE  TABLE IF NOT EXISTS `dependent` (
      `id` INT(11) NOT NULL AUTO_INCREMENT ,
      `parent1_person_id` INT(11) NULL DEFAULT NULL ,
      `parent2_person_id` INT(11) NULL DEFAULT NULL ,
      `first_name` VARCHAR(45) NULL DEFAULT NULL ,
      `last_name` VARCHAR(45) NULL DEFAULT NULL ,
      `min_dob` DATE NULL ,
      `exact_dob` DATE NULL ,
      `max_dob` DATE NULL ,
      PRIMARY KEY (`id`) ,
      INDEX fk_dependent_person (`parent1_person_id` ASC) ,
      INDEX fk_dependent_person1 (`parent2_person_id` ASC) ,
      CONSTRAINT `fk_dependent_person`
	FOREIGN KEY (`parent1_person_id` )
	REFERENCES `person` (`id` )
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
      CONSTRAINT `fk_dependent_person1`
	FOREIGN KEY (`parent2_person_id` )
	REFERENCES `person` (`id` )
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8
    COLLATE = utf8_general_ci"

execute "
CREATE  TABLE IF NOT EXISTS `other_opportunity_values` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `household_id` INT(11) NULL DEFAULT NULL ,
  `number_of_years_until_retirement` INT(11) NULL DEFAULT NULL ,
  `current_household_income_in_cents` INT(11) NULL DEFAULT NULL ,
  `projected_household_income_at_retirement_in_cents` INT(11) NULL DEFAULT NULL ,
  `pv_of_required_funds_at_retirement_in_cents` INT(11) NULL DEFAULT NULL ,
  `number_of_dependents` INT(11) NULL DEFAULT NULL ,
  `total_funds_for_public_in_state_all_deps_in_cents` INT(11) NULL DEFAULT NULL ,
  `total_funds_for_private_all_deps_in_cents` INT(11) NULL DEFAULT NULL ,
  `total_funds_for_public_out_of_state_all_deps_in_cents` INT(11) NULL DEFAULT NULL ,
  `total_consumer_debt_in_cents` INT(11) NULL DEFAULT NULL ,
  `equivalent_monthly_debt_payment_in_cents` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_other_opportunity_values_household (`household_id` ASC) ,
  CONSTRAINT `fk_other_opportunity_values_household`
    FOREIGN KEY (`household_id` )
    REFERENCES `household` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;"


execute "CREATE  TABLE IF NOT EXISTS `college_planning_values` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `dependent_id` INT(11) NULL DEFAULT NULL ,
  `years_until_college` INT(11) NULL DEFAULT NULL ,
  `cost_of_public_in_state_college_in_cents` INT(11) NULL DEFAULT NULL ,
  `cost_of_private_college_in_cents` INT(11) NULL DEFAULT NULL ,
  `cost_of_public_out_of_state_college_in_cents` INT(11) NULL DEFAULT NULL ,
  `funds_needed_for_public_in_state_college_in_cents` INT(11) NULL DEFAULT NULL ,
  `funds_needed_for_private_college_in_cents` INT(11) NULL DEFAULT NULL ,
  `funds_needed_for_public_out_of_state_college_in_cents` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_college_planning_values_dependent (`dependent_id` ASC) ,
  INDEX fk_college_planning_values_other_opportunity_values (`cost_of_public_in_state_college_in_cents` ASC) ,
  CONSTRAINT `fk_college_planning_values_dependent`
    FOREIGN KEY (`dependent_id` )
    REFERENCES `dependent` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_college_planning_values_other_opportunity_values`
    FOREIGN KEY (`cost_of_public_in_state_college_in_cents` )
    REFERENCES `other_opportunity_values` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;"



  end

  def self.down	
    execute "drop table college_planning_values";
    execute "drop table dependent"
    execute "drop table other_opportunity_values";
  end
end
