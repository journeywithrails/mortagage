class ServerTaskClasses < ActiveRecord::Migration
  def self.up
    execute "
CREATE  TABLE IF NOT EXISTS `task_class` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;"

    execute "
CREATE  TABLE IF NOT EXISTS `server_task_class_count` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `task_class_id` INT(11) NOT NULL ,
  `server_id` INT(10) UNSIGNED NOT NULL ,
  `thread_count` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_server_task_class_count_task_class (`task_class_id` ASC) ,
  INDEX fk_server_task_class_count_server (`server_id` ASC) ,
  CONSTRAINT `fk_server_task_class_count_task_class`
    FOREIGN KEY (`task_class_id` )
    REFERENCES `task_class` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_server_task_class_count_server`
    FOREIGN KEY (`server_id` )
    REFERENCES `server` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;"
    
    execute "
ALTER TABLE `job` ADD COLUMN `task_class_id` INT(11) NULL DEFAULT NULL  AFTER `job_results` , ADD CONSTRAINT `fk_job_process_type_task_class`
  FOREIGN KEY (`task_class_id` )
  REFERENCES `task_class` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION, ADD INDEX fk_job_process_type_task_class (`task_class_id` ASC) , ADD INDEX ix_server_class (`server_id` ASC, `job_status_type_id` ASC, `task_class_id` ASC) ;"

    execute "ALTER TABLE `process_type` ADD COLUMN `class_name` VARCHAR(255) NULL DEFAULT NULL  AFTER `name` ;"
  
  end

  def self.down
    execute "alter table job drop column task_class_id"
    execute "drop table server_task_class_count"
    execute "drop table task_class"
  end
end
