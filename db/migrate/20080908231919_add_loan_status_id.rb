class AddLoanStatusId < ActiveRecord::Migration
  def self.up
    execute "
CREATE TABLE IF NOT EXISTS `loan_status` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `status_name` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
"


    execute "
ALTER TABLE `loan` ADD COLUMN `loan_status_id` INT(11) NULL DEFAULT NULL  AFTER `user_id` , ADD CONSTRAINT `fk_loan_loan_status`
  FOREIGN KEY (`loan_status_id` )
  REFERENCES `loan_status` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION, ADD INDEX fk_loan_loan_status (`loan_status_id` ASC) ;
"

    execute "SET AUTOCOMMIT=0;"
    execute "INSERT INTO `loan_status` (`id`, `status_name`) VALUES (1, 'Closed');"
    execute "INSERT INTO `loan_status` (`id`, `status_name`) VALUES (2, 'Open');"
    execute "INSERT INTO `loan_status` (`id`, `status_name`) VALUES (3, 'Abandoned');"
    execute "INSERT INTO `loan_status` (`id`, `status_name`) VALUES (4, 'Proposed');"

    execute "update loan set loan_status_id = 1;"
  end

  def self.down
    # not worth it
  end
end
