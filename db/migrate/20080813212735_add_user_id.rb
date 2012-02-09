class AddUserId < ActiveRecord::Migration
  def self.up
    execute "
CREATE TABLE `broker`.`user` (
  `id` INTEGER UNSIGNED NOT NULL,
  `account_id` INTEGER UNSIGNED NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`)) ENGINE=InnoDB;
"
  execute "
insert into `broker`.`user` (id, account_id, email) (select id, account_id, email from `account`.`user`);
"
  execute "
ALTER TABLE `broker`.`account_upload` ADD COLUMN `user_id` INTEGER UNSIGNED AFTER `id`;
"
  execute "
ALTER TABLE `broker`.`job` ADD COLUMN `user_id` INTEGER UNSIGNED AFTER `id`;
"
  execute "
  ALTER TABLE `broker`.`household` ADD COLUMN `user_id` INTEGER UNSIGNED AFTER `id`;
"
  execute "
update `broker`.`account_upload` b set user_id = (select id from `broker`.`user` u where u.account_id = b.account_id);
"
  execute "
update `broker`.`job` b set user_id = (select id from `broker`.`user` u where u.account_id = b.account_id);
"
  execute "
update `broker`.`household` b set user_id = (select id from `broker`.`user` u where u.account_id = b.account_id);
"
  execute "update `broker`.`account_upload` set user_id = (select id from `broker`.`user` limit 1) where user_id is null"
  execute "update `broker`.`job` set user_id = (select id from `broker`.`user` limit 1) where user_id is null"
  execute "update `broker`.`household` set user_id = (select id from `broker`.`user` limit 1) where user_id is null"
  execute " 
ALTER TABLE `broker`.`account_upload` MODIFY COLUMN `user_id` INTEGER UNSIGNED NOT NULL;
"
  execute "
ALTER TABLE `broker`.`job` MODIFY COLUMN `user_id` INTEGER UNSIGNED NOT NULL;
"
  execute "
ALTER TABLE `broker`.`household` MODIFY COLUMN `user_id` INTEGER UNSIGNED NOT NULL;   
"
execute "
ALTER TABLE `broker`.`account_upload` ADD CONSTRAINT `FK_account_upload_user_id` FOREIGN KEY `FK_account_upload_user_id` (`user_id`)
    REFERENCES `broker`.`user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
"
  execute "   
ALTER TABLE `broker`.`job` ADD CONSTRAINT `FK_job_user_id` FOREIGN KEY `FK_job_user_id` (`user_id`)
    REFERENCES `broker`.`user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
"
  execute "    
ALTER TABLE `broker`.`household` ADD CONSTRAINT `FK_household_user_id` FOREIGN KEY `FK_household_user_id` (`user_id`)
    REFERENCES `broker`.`user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
"
end

  def self.down
    execute "ALTER TABLE `broker`.`household` DROP FOREIGN KEY `FK_household_user_id`;" 
    execute "ALTER TABLE `broker`.`job` DROP FOREIGN KEY `FK_job_user_id`;"
    execute "ALTER TABLE `broker`.`account_upload` DROP FOREIGN KEY `FK_account_upload_user_id`;"

    execute "ALTER TABLE `broker`.`account_upload` DROP COLUMN `user_id`;"
    execute "ALTER TABLE `broker`.`job` DROP COLUMN `user_id`;"
    execute "ALTER TABLE `broker`.`household` DROP COLUMN `user_id`;"

    execute "drop table `broker`.`user`;"    
  end
end
