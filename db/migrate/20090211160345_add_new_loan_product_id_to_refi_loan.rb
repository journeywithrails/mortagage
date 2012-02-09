class AddNewLoanProductIdToRefiLoan < ActiveRecord::Migration
  def self.up

    execute "ALTER TABLE `refi_property`  DROP FOREIGN KEY `fk_refi_property_refi_scenario`"
    execute "ALTER TABLE `refi_loan` ADD COLUMN `new_loan_product_id` INT(11) NULL DEFAULT NULL  AFTER `total_principal_in_cents` , DROP FOREIGN KEY `fk_refi_loan_refi_property` ;"
    execute "ALTER TABLE `refi_property` ADD CONSTRAINT `fk_refi_property_refi_scenario`
		FOREIGN KEY (`refi_scenario_id` )
		REFERENCES `refi_scenario` (`id` )
		ON DELETE CASCADE
		ON UPDATE CASCADE;"

    execute "ALTER TABLE `refi_loan` ADD CONSTRAINT `fk_refi_loan_new_loan_product`
		FOREIGN KEY (`new_loan_product_id` )
		REFERENCES `new_loan_product` (`id` )
		ON DELETE NO ACTION
		ON UPDATE NO ACTION, ADD CONSTRAINT `fk_refi_loan_refi_property`
		FOREIGN KEY (`refi_property_id` )
		REFERENCES `refi_property` (`id` )
		ON DELETE CASCADE
		ON UPDATE CASCADE, ADD INDEX fk_refi_loan_new_loan_product (`new_loan_product_id` ASC) ;"
  end

  def self.down
    execute "ALTER TABLE `refi_property`  DROP FOREIGN KEY `fk_refi_property_refi_scenario` ;"

    execute "ALTER TABLE `refi_loan` DROP FOREIGN KEY `fk_refi_loan_refi_property`,DROP FOREIGN KEY `fk_refi_loan_new_loan_product`, DROP COLUMN `new_loan_product_id`;"

    execute "ALTER TABLE `refi_property` ADD CONSTRAINT `fk_refi_property_refi_scenario`
	      FOREIGN KEY (`refi_scenario_id` )
	      REFERENCES `refi_scenario` (`id` )
	      ON DELETE NO ACTION
	      ON UPDATE NO ACTION;"


    execute "ALTER TABLE `refi_loan` ADD CONSTRAINT `fk_refi_loan_refi_property`
	      FOREIGN KEY (`refi_property_id` )
	      REFERENCES `refi_property` (`id` )
	      ON DELETE NO ACTION
	      ON UPDATE NO ACTION;"
  end
end
