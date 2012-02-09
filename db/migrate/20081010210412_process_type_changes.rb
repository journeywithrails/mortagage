class ProcessTypeChanges < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE `process_type` CHANGE COLUMN `id` `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT"
    execute "ALTER TABLE `task_class` CHANGE COLUMN `id` `id` INT(11) NOT NULL"

    execute "ALTER TABLE `amortization_schedule` CHANGE COLUMN `interest` `interest` DOUBLE NULL DEFAULT NULL, 
	CHANGE COLUMN `principle` `principle` DOUBLE NULL DEFAULT NULL, 
	CHANGE COLUMN `remaining_bal` `remaining_bal` DOUBLE NULL DEFAULT NULL;"
  end

  def self.down
  end
end
