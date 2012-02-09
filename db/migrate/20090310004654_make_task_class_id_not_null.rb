class MakeTaskClassIdNotNull < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE `job` CHANGE COLUMN `task_class_id` `task_class_id` INT(11) NOT NULL DEFAULT 1  ;"
  end

  def self.down
    execute "ALTER TABLE `job` CHANGE COLUMN `task_class_id` `task_class_id` INT(11);"
  end
end
