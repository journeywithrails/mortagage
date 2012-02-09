class CreateNewLoanTables < ActiveRecord::Migration
  def self.up
    execute "
CREATE  TABLE IF NOT EXISTS `cost_type` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;"

execute "
CREATE  TABLE IF NOT EXISTS `closing_scenario` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(120) NULL ,
  `origination_amount` INT NULL ,
  `origination_pct` FLOAT NULL ,
  `discount_amount` INT NULL ,
  `discount_pct` FLOAT NULL ,
  `application_fee` INT NULL ,
  `appraisal` INT NULL ,
  `commitment_fee` INT NULL ,
  `credit_report` INT NULL ,
  `document_preparation` INT NULL ,
  `extension_fee` INT NULL ,
  `flood_certificate` INT NULL ,
  `funding_fee` INT NULL ,
  `postage` INT NULL ,
  `processing` INT NULL ,
  `service_fee` INT NULL ,
  `tax_service_amount` INT NULL ,
  `tax_service_pct` FLOAT NULL ,
  `underwriting` INT NULL ,
  `wire_transfer` INT NULL ,
  `origination_cost_type_id` INT UNSIGNED NULL ,
  `discount_cost_type_id` INT UNSIGNED NULL ,
  `application_cost_type_id` INT UNSIGNED NULL ,
  `appraisal_cost_type_id` INT UNSIGNED NULL ,
  `commitment_cost_type_id` INT UNSIGNED NULL ,
  `credit_report_cost_type_id` INT UNSIGNED NULL ,
  `document_preparation_cost_type_id` INT UNSIGNED NULL ,
  `extension_cost_type_id` INT UNSIGNED NULL ,
  `flood_certificate_cost_type_id` INT UNSIGNED NULL ,
  `funding_cost_type_id` INT UNSIGNED NULL ,
  `postage_cost_type_id` INT UNSIGNED NULL ,
  `service_cost_type_id` INT UNSIGNED NULL ,
  `tax_service_cost_type_id` INT UNSIGNED NULL ,
  `underwriting_cost_type_id` INT UNSIGNED NULL ,
  `wire_transfer_cost_type_id` INT UNSIGNED NULL ,
  `processing_cost_type_id` INT UNSIGNED NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_closing_scenario_cost_type (`origination_cost_type_id` ASC) ,
  INDEX fk_closing_scenario_cost_type1 (`discount_cost_type_id` ASC) ,
  INDEX fk_closing_scenario_cost_type2 (`application_cost_type_id` ASC) ,
  INDEX fk_closing_scenario_cost_type3 (`appraisal_cost_type_id` ASC) ,
  INDEX fk_closing_scenario_cost_type4 (`commitment_cost_type_id` ASC) ,
  INDEX fk_closing_scenario_cost_type5 (`credit_report_cost_type_id` ASC) ,
  INDEX fk_closing_scenario_cost_type6 (`document_preparation_cost_type_id` ASC) ,
  INDEX fk_closing_scenario_cost_type7 (`extension_cost_type_id` ASC) ,
  INDEX fk_closing_scenario_cost_type8 (`flood_certificate_cost_type_id` ASC) ,
  INDEX fk_closing_scenario_cost_type9 (`funding_cost_type_id` ASC) ,
  INDEX fk_closing_scenario_cost_type10 (`postage_cost_type_id` ASC) ,
  INDEX fk_closing_scenario_cost_type11 (`service_cost_type_id` ASC) ,
  INDEX fk_closing_scenario_cost_type12 (`tax_service_cost_type_id` ASC) ,
  INDEX fk_closing_scenario_cost_type13 (`underwriting_cost_type_id` ASC) ,
  INDEX fk_closing_scenario_cost_type14 (`wire_transfer_cost_type_id` ASC) ,
  INDEX fk_closing_scenario_cost_type15 (`processing_cost_type_id` ASC) ,
  CONSTRAINT `fk_closing_scenario_cost_type`
    FOREIGN KEY (`origination_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_closing_scenario_cost_type1`
    FOREIGN KEY (`discount_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_closing_scenario_cost_type2`
    FOREIGN KEY (`application_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_closing_scenario_cost_type3`
    FOREIGN KEY (`appraisal_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_closing_scenario_cost_type4`
    FOREIGN KEY (`commitment_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_closing_scenario_cost_type5`
    FOREIGN KEY (`credit_report_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_closing_scenario_cost_type6`
    FOREIGN KEY (`document_preparation_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_closing_scenario_cost_type7`
    FOREIGN KEY (`extension_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_closing_scenario_cost_type8`
    FOREIGN KEY (`flood_certificate_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_closing_scenario_cost_type9`
    FOREIGN KEY (`funding_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_closing_scenario_cost_type10`
    FOREIGN KEY (`postage_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_closing_scenario_cost_type11`
    FOREIGN KEY (`service_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_closing_scenario_cost_type12`
    FOREIGN KEY (`tax_service_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_closing_scenario_cost_type13`
    FOREIGN KEY (`underwriting_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_closing_scenario_cost_type14`
    FOREIGN KEY (`wire_transfer_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_closing_scenario_cost_type15`
    FOREIGN KEY (`processing_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
"

execute "
CREATE  TABLE IF NOT EXISTS `title_fee_scenario` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(120) NULL ,
  `settlement_fee` INT NULL ,
  `city_county_fee` INT NULL ,
  `closing` INT NULL ,
  `commitment` INT NULL ,
  `endorsement` INT NULL ,
  `exam` INT NULL ,
  `lender_policy` INT NULL ,
  `notary_fee` INT NULL ,
  `owners_policy` INT NULL ,
  `inspection` INT NULL ,
  `recording_fee` INT NULL ,
  `title_insurance` INT NULL ,
  `title_search` INT NULL ,
  `state_fee` INT NULL ,
  `survey_fee` INT NULL ,
  `settlement_cost_type_id` INT UNSIGNED NULL ,
  `city_county_cost_type_id` INT UNSIGNED NULL ,
  `closing_cost_type_id` INT UNSIGNED NULL ,
  `commitment_cost_type_id` INT UNSIGNED NULL ,
  `endorsement_cost_type_id` INT UNSIGNED NULL ,
  `exam_cost_type_id` INT UNSIGNED NULL ,
  `lender_policy_cost_type_id` INT UNSIGNED NULL ,
  `notary_cost_type_id` INT UNSIGNED NULL ,
  `owners_policy_cost_type_id` INT UNSIGNED NULL ,
  `inspection_cost_type_id` INT UNSIGNED NULL ,
  `recording_cost_type_id` INT UNSIGNED NULL ,
  `title_insurance_cost_type_id` INT UNSIGNED NULL ,
  `title_search_cost_type_id` INT UNSIGNED NULL ,
  `state_cost_type_id` INT UNSIGNED NULL ,
  `survey_cost_type_id` INT UNSIGNED NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_title_fee_scenario_cost_type (`settlement_cost_type_id` ASC) ,
  INDEX fk_title_fee_scenario_cost_type1 (`city_county_cost_type_id` ASC) ,
  INDEX fk_title_fee_scenario_cost_type2 (`closing_cost_type_id` ASC) ,
  INDEX fk_title_fee_scenario_cost_type3 (`commitment_cost_type_id` ASC) ,
  INDEX fk_title_fee_scenario_cost_type4 (`endorsement_cost_type_id` ASC) ,
  INDEX fk_title_fee_scenario_cost_type5 (`exam_cost_type_id` ASC) ,
  INDEX fk_title_fee_scenario_cost_type6 (`lender_policy_cost_type_id` ASC) ,
  INDEX fk_title_fee_scenario_cost_type7 (`notary_cost_type_id` ASC) ,
  INDEX fk_title_fee_scenario_cost_type8 (`owners_policy_cost_type_id` ASC) ,
  INDEX fk_title_fee_scenario_cost_type9 (`inspection_cost_type_id` ASC) ,
  INDEX fk_title_fee_scenario_cost_type10 (`recording_cost_type_id` ASC) ,
  INDEX fk_title_fee_scenario_cost_type11 (`title_insurance_cost_type_id` ASC) ,
  INDEX fk_title_fee_scenario_cost_type12 (`title_search_cost_type_id` ASC) ,
  INDEX fk_title_fee_scenario_cost_type13 (`state_cost_type_id` ASC) ,
  INDEX fk_title_fee_scenario_cost_type14 (`survey_cost_type_id` ASC) ,
  CONSTRAINT `fk_title_fee_scenario_cost_type`
    FOREIGN KEY (`settlement_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_title_fee_scenario_cost_type1`
    FOREIGN KEY (`city_county_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_title_fee_scenario_cost_type2`
    FOREIGN KEY (`closing_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_title_fee_scenario_cost_type3`
    FOREIGN KEY (`commitment_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_title_fee_scenario_cost_type4`
    FOREIGN KEY (`endorsement_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_title_fee_scenario_cost_type5`
    FOREIGN KEY (`exam_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_title_fee_scenario_cost_type6`
    FOREIGN KEY (`lender_policy_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_title_fee_scenario_cost_type7`
    FOREIGN KEY (`notary_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_title_fee_scenario_cost_type8`
    FOREIGN KEY (`owners_policy_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_title_fee_scenario_cost_type9`
    FOREIGN KEY (`inspection_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_title_fee_scenario_cost_type10`
    FOREIGN KEY (`recording_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_title_fee_scenario_cost_type11`
    FOREIGN KEY (`title_insurance_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_title_fee_scenario_cost_type12`
    FOREIGN KEY (`title_search_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_title_fee_scenario_cost_type13`
    FOREIGN KEY (`state_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_title_fee_scenario_cost_type14`
    FOREIGN KEY (`survey_cost_type_id` )
    REFERENCES `cost_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
"

    
    execute "
CREATE  TABLE IF NOT EXISTS `proposal` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(120) NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NULL ,
  `purchase_price` INT NULL ,
  `down_payment_amount` INT NULL ,
  `down_payment_pct` FLOAT NULL ,
  `household_id` INT(11) NULL ,
  `property_id` INT(11) NULL ,
  `closing_scenario_id` INT UNSIGNED NULL ,
  `title_fee_scenario_id` INT UNSIGNED NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_proposal_household (`household_id` ASC) ,
  INDEX fk_proposal_property (`property_id` ASC) ,
  INDEX fk_proposal_closing_scenario (`closing_scenario_id` ASC) ,
  INDEX fk_proposal_title_fee_scenario (`title_fee_scenario_id` ASC) ,
  CONSTRAINT `fk_proposal_household`
    FOREIGN KEY (`household_id` )
    REFERENCES `household` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proposal_property`
    FOREIGN KEY (`property_id` )
    REFERENCES `property` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proposal_closing_scenario`
    FOREIGN KEY (`closing_scenario_id` )
    REFERENCES `closing_scenario` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proposal_title_fee_scenario`
    FOREIGN KEY (`title_fee_scenario_id` )
    REFERENCES `title_fee_scenario` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;"
   
   execute "
CREATE  TABLE IF NOT EXISTS `proposal_loan` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `proposal_id` INT UNSIGNED NULL ,
  `loan_id` INT(11) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_proposal_loan_proposal (`proposal_id` ASC) ,
  INDEX fk_proposal_loan_loan (`loan_id` ASC) ,
  CONSTRAINT `fk_proposal_loan_proposal`
    FOREIGN KEY (`proposal_id` )
    REFERENCES `proposal` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proposal_loan_loan`
    FOREIGN KEY (`loan_id` )
    REFERENCES `loan` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;"
   
   execute "
CREATE  TABLE IF NOT EXISTS `tax_filing_status` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(60) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;"

  execute "
CREATE  TABLE IF NOT EXISTS `tax_rate` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `top_income` INT NOT NULL ,
  `tax_pct` FLOAT NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;"
  
  execute "ALTER TABLE `person` add column `phone_home` VARCHAR(15) NULL;"
  execute "ALTER TABLE `person` add column `phone_work` VARCHAR(15) NULL;"
  execute "ALTER TABLE `person` add column `phone_mobile` VARCHAR(15) NULL;"
  execute "ALTER TABLE `person` add column `fax` VARCHAR(15) NULL;"
  execute "ALTER TABLE `person` add column `email` VARCHAR(80) NULL;"

  execute "ALTER TABLE `household` add column `estimated_income` INT NULL;" 
  execute "ALTER TABLE `household` add column `current_property_id` INT(11) NULL;"
  execute "ALTER TABLE `household` add column `tax_rate_id` INT UNSIGNED NULL;"
  execute "ALTER TABLE `household` add column `tax_filing_status_id` INT UNSIGNED NULL;"
  execute "ALTER TABLE `household` add column `fico_score` INT NULL;"
  execute "ALTER TABLE `household` add column `property_tax_pct` FLOAT NULL;"
  execute "ALTER TABLE `household` add INDEX fk_household_property (`current_property_id` ASC);"
  execute "ALTER TABLE `household` add INDEX fk_household_tax_rate (`tax_rate_id` ASC);"
  execute "ALTER TABLE `household` add INDEX fk_household_tax_filing_status (`tax_filing_status_id` ASC);"
  execute "ALTER TABLE `household` add CONSTRAINT `fk_household_property`
    FOREIGN KEY (`current_property_id` )
    REFERENCES `property` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;"
  execute "ALTER TABLE `household` add CONSTRAINT `fk_household_tax_rate`
    FOREIGN KEY (`tax_rate_id` )
    REFERENCES `tax_rate` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;"
  execute "ALTER TABLE `household` add CONSTRAINT `fk_household_tax_filing_status`
    FOREIGN KEY (`tax_filing_status_id` )
    REFERENCES `tax_filing_status` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;"    
  end

  def self.down
    # not worth writing
  end
end
