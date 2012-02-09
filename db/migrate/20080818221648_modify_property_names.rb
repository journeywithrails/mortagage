class ModifyPropertyNames < ActiveRecord::Migration
  def self.up
    execute "
ALTER TABLE `global_property` CHANGE COLUMN `property_name` `name` VARCHAR(50) NOT NULL
"
    execute "
ALTER TABLE `process_type_property` CHANGE COLUMN `property_name` `name` VARCHAR(50) NOT NULL
"
    execute "
ALTER TABLE `server_property` CHANGE COLUMN `property_name` `name` VARCHAR(50) NOT NULL
" 
execute "
insert into  `global_property` (name, property_value) values ('UploadRoot', 'You need to set the Global Property UploadRoot')
"
execute "
insert into  `global_property` (name, property_value) values ('UserFilesRoot', 'You need to set the Global Property UserFilesRoot');
"
  end

  def self.down
    execute "
ALTER TABLE `global_property` CHANGE COLUMN `name` `property_name` VARCHAR(50) NOT NULL
"
execute "
ALTER TABLE `process_type_property` CHANGE COLUMN `name` `property_name` VARCHAR(50) NOT NULL
"
execute "
ALTER TABLE `server_property` CHANGE COLUMN `name` `property_name` VARCHAR(50) NOT NULL
"    
  end
end
