class RefiScenarioCascadeSetNull < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE `household`  DROP FOREIGN KEY `FK_household_refi_scenario`;"

    execute "ALTER TABLE `household` ADD CONSTRAINT `FK_household_refi_scenario` FOREIGN KEY `FK_household_refi_scenario` (`refi_scenario_id`)
    REFERENCES `refi_scenario` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION;"
  end

  def self.down
  end
end
