class CreateHousingType < ActiveRecord::Migration
  def self.up
    execute " 
CREATE  TABLE IF NOT EXISTS `housing_type` (
  `id` INT(11) NOT NULL ,
  `name` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;"

    execute "
ALTER TABLE `property` ADD COLUMN `housing_type_id` INT(11) NULL DEFAULT NULL  AFTER `property_use_id` , ADD CONSTRAINT `fk_property_housing_type`
  FOREIGN KEY (`housing_type_id` )
  REFERENCES `housing_type` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION, ADD INDEX fk_property_housing_type (`housing_type_id` ASC) ;"

    execute "
ALTER TABLE `person_financial` ADD COLUMN `base_income_in_cents` INT(11) NULL DEFAULT NULL  AFTER `person_id` , ADD COLUMN `bonuses_in_cents` INT(11) NULL DEFAULT NULL  AFTER `base_income_in_cents` , ADD COLUMN `commissions_in_cents` INT(11) NULL DEFAULT NULL  AFTER `bonuses_in_cents` , ADD COLUMN `date` DATE NULL  AFTER `person_id` , ADD COLUMN `equifax_credit_score` INT(11) NULL DEFAULT NULL  AFTER `date` , ADD COLUMN `net_rental_income_in_cents` INT(11) NULL DEFAULT NULL  AFTER `commissions_in_cents` , ADD COLUMN `other_income_in_cents` INT(11) NULL DEFAULT NULL  AFTER `net_rental_income_in_cents` , ADD COLUMN `overtime_in_cents` INT(11) NULL DEFAULT NULL  AFTER `base_income_in_cents` , ADD COLUMN `transunion_credit_score` INT(11) NULL DEFAULT NULL  AFTER `equifax_credit_score` , CHANGE COLUMN `fico_score` `experian_credit_score` INT(11) NULL DEFAULT NULL  AFTER `date` ;"
  end

  def self.down
    execute "alter table `property` drop foreign key fk_property_housing_type"
    execute "alter TABLE `property` drop column housing_type_id"
    execute "drop table housing_type"
    execute "alter table person_financial drop column base_income_in_cents, drop column bonuses_in_cents, drop column equifax_credit_score, drop column net_rental_income_in_cents, drop column commissions_in_cents, drop column other_income_in_cents, drop column overtime_in_cents, drop column transunion_credit_score, drop column date"
    execute "alter table person_financial change column experian_credit_score fico_score int"
  end
end
