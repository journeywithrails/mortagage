class AddLoanPurposeAndUpdatePersonFinancial < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE `person_financial` ADD COLUMN `dependent_ages` VARCHAR(45) NULL DEFAULT NULL  AFTER `other_income_in_cents` ,
		    ADD COLUMN `employer_name` VARCHAR(45) NULL DEFAULT NULL  AFTER `other_income_in_cents`  ;"


    execute "CREATE  TABLE IF NOT EXISTS `loan_purpose` (
		`id` INT(11) NOT NULL ,
		`name` VARCHAR(45) NULL DEFAULT NULL ,
		PRIMARY KEY (`id`) )
	      ENGINE = InnoDB
	      DEFAULT CHARACTER SET = utf8
	      COLLATE = utf8_general_ci;"




    execute "ALTER TABLE `loan` ADD COLUMN `loan_purpose_id` INT(11) NULL DEFAULT NULL  AFTER `open_date`,
		ADD CONSTRAINT `fk_loan_loan_purpose`
		FOREIGN KEY (`loan_purpose_id` )
		REFERENCES `loan_purpose` (`id` )
		ON DELETE NO ACTION
		ON UPDATE NO ACTION, ADD INDEX fk_loan_loan_purpose (`loan_purpose_id` ASC) ;"
  end

  def self.down
    execute "alter table loan drop foreign key fk_loan_loan_purpose;"
    execute "alter table loan drop key fk_loan_loan_purpose;"
    execute "alter table loan drop column loan_purpose_id;"
    execute "drop table loan_purpose"
    execute "ALTER TABLE `person_financial` DROP COLUMN `dependent_ages`, DROP COLUMN `employer_name`;"
  end
end
