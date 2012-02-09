class UpdateContactInfo < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE `household` DROP COLUMN `current_property_id`,
 DROP FOREIGN KEY `fk_household_property`;"
 
    execute "ALTER TABLE `household` ADD COLUMN `is_dirty` TINYINT(1);"

    execute "update household set is_dirty = 0;"
    execute "ALTER TABLE `household` ADD INDEX `ix_household_is_dirty`(`is_dirty`);"

    execute "alter table person 
	add column address1 varchar(255),
	add column address2 varchar(255),
	add column city varchar(45),
	add column state varchar(5),
	add column zip varchar(15),
	add column updated_at datetime;"
    
  end

  def self.down
  end
end
