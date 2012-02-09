class UpdateNewLoan < ActiveRecord::Migration
  def self.up
    execute "alter table proposal rename to proposal_scenario;"
    execute "alter table proposal_loan rename to proposal_scenario_loan;"

    execute "alter table proposal_scenario_loan drop foreign key fk_proposal_loan_proposal;"
    execute "alter table proposal_scenario_loan change proposal_id proposal_scenario_id int(10) unsigned default null;"
    execute "
  alter table proposal_scenario_loan add constraint fk_proposal_loan_proposal 
    foreign key (proposal_scenario_id) references proposal_scenario(id) on delete no action on update no action;"

    execute "alter table proposal_scenario drop column household_id, drop foreign key fk_proposal_household;"
    execute "alter table proposal_scenario drop column property_id, drop foreign key fk_proposal_property;"

    execute "alter table household drop column tax_rate_id, drop foreign key fk_household_tax_rate;"
    execute "alter table household drop column tax_filing_status_id, drop foreign key fk_household_tax_filing_status;"
    execute "alter table household drop column estimated_income;"
    execute "alter table household drop column fico_score;"
    execute "alter table household drop column property_tax_pct;"

    execute "
CREATE TABLE IF NOT EXISTS proposal (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(120) NOT NULL ,
  `created_at` DATETIME NULL ,
  `updated_at` DATETIME NULL ,
  `household_id` INT(11) NOT NULL ,
  `property_id` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_proposal_household (`household_id` ASC) ,
  INDEX fk_proposal_property (`property_id` ASC) ,
  CONSTRAINT `fk_proposal_household`
    FOREIGN KEY (`household_id` )
    REFERENCES `household` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proposal_property`
    FOREIGN KEY (`property_id` )
    REFERENCES `property` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;"

    execute "alter table proposal_scenario add column proposal_id INT UNSIGNED NULL;"
    execute "alter table proposal_scenario add INDEX fk_proposal_scenario_proposal (proposal_id ASC);"
    execute "alter table proposal_scenario add constraint fk_proposal_scenario_proposal
    FOREIGN KEY fk_proposal_scenario_proposal (proposal_id)
    REFERENCES proposal (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;"

    execute "
CREATE TABLE IF NOT EXISTS `person_financial` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `fico_score` INT NULL ,
  `person_id` INT(11) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_person_financial_person (`person_id` ASC) ,
  CONSTRAINT `fk_person_financial_person`
    FOREIGN KEY (`person_id` )
    REFERENCES `person` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;"

    execute "
CREATE TABLE IF NOT EXISTS `household_financial` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created_at` DATETIME NOT NULL ,
  `estimated_income` INT NULL ,
  `tax_filing_status_id` INT UNSIGNED NULL ,
  `tax_rate_id` INT UNSIGNED NULL ,
  `household_id` INT(11) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_household_financial_tax_filing_status (`tax_filing_status_id` ASC) ,
  INDEX fk_household_financial_tax_rate (`tax_rate_id` ASC) ,
  INDEX fk_household_financial_household (`household_id` ASC) ,
  CONSTRAINT `fk_household_financial_tax_filing_status`
    FOREIGN KEY (`tax_filing_status_id` )
    REFERENCES `tax_filing_status` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_household_financial_tax_rate`
    FOREIGN KEY (`tax_rate_id` )
    REFERENCES `tax_rate` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_household_financial_household`
    FOREIGN KEY (`household_id` )
    REFERENCES `household` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;"
  end

  def self.down
    # not worth it
  end
end
