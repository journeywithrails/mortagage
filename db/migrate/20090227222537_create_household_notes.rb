class CreateHouseholdNotes < ActiveRecord::Migration
  def self.up
    execute "CREATE TABLE `household_note` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `household_id` INT NOT NULL,
  `note` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_hh_hh_note` FOREIGN KEY `fk_hh_hh_note` (`household_id`)
    REFERENCES `household` (`id`)
)
ENGINE = InnoDB
CHARACTER SET utf8;"
  end

  def self.down
    drop_table "household_note"
  end
end
