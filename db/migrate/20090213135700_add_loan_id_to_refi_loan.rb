class AddLoanIdToRefiLoan < ActiveRecord::Migration
  def self.up
	execute "ALTER TABLE `refi_loan` ADD COLUMN `loan_id` INT(11) NULL DEFAULT NULL  AFTER `new_loan_product_id`, ADD CONSTRAINT `fk_refi_loan_loan` 
  FOREIGN KEY (`loan_id` )
  REFERENCES `broker`.`loan` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION, ADD INDEX fk_refi_loan_loan (`loan_id` ASC) ;"
  end

  def self.down
    execute "alter table refi_loan drop foreign key fk_refi_loan_loan"
	execute "ALTER TABLE refi_loan DROP COLUMN loan_id";
  end
end
