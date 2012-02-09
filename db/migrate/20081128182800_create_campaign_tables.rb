class CreateCampaignTables < ActiveRecord::Migration
  def self.up
    execute "
CREATE  TABLE IF NOT EXISTS `report_type` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(80) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;"

execute "
CREATE  TABLE IF NOT EXISTS `campaign_channel` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;"

execute "
CREATE  TABLE IF NOT EXISTS `campaign` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(80) NOT NULL ,
  `campaign_channel_id` INT UNSIGNED NOT NULL ,
  `created_at` DATETIME NOT NULL ,
  `execute_at` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_campaign_campaign_channel (`campaign_channel_id` ASC) ,
  CONSTRAINT `fk_campaign_campaign_channel`
    FOREIGN KEY (`campaign_channel_id` )
    REFERENCES `campaign_channel` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;"

execute "
CREATE  TABLE IF NOT EXISTS `campaign_criteria` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `campaign_id` INT UNSIGNED NOT NULL ,
  `column_name` VARCHAR(50) NOT NULL ,
  `column_value` VARCHAR(80) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_campaign_criteria_campaign (`campaign_id` ASC) ,
  CONSTRAINT `fk_campaign_criteria_campaign`
    FOREIGN KEY (`campaign_id` )
    REFERENCES `campaign` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;"

execute "
CREATE  TABLE IF NOT EXISTS `campaign_report_map` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `campaign_id` INT UNSIGNED NULL ,
  `report_type_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_campaign_report_map_campaign (`campaign_id` ASC) ,
  INDEX fk_campaign_report_map_report_type (`report_type_id` ASC) ,
  CONSTRAINT `fk_campaign_report_map_campaign`
    FOREIGN KEY (`campaign_id` )
    REFERENCES `campaign` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campaign_report_map_report_type`
    FOREIGN KEY (`report_type_id` )
    REFERENCES `report_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;"

execute "
CREATE  TABLE IF NOT EXISTS `campaign_report_household_map` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `campaign_report_map_id` INT UNSIGNED NOT NULL ,
  `household_id` INT NOT NULL ,
  `report_file` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_campaign_report_household_map_campaign_report_map (`campaign_report_map_id` ASC) ,
  INDEX fk_crhm_hh (`household_id` ASC) ,
  CONSTRAINT `fk_campaign_report_household_map_campaign_report_map`
    FOREIGN KEY (`campaign_report_map_id` )
    REFERENCES `campaign_report_map` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_crhm_hh`
    FOREIGN KEY (`household_id` )
    REFERENCES `household` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;"

execute "
CREATE  TABLE IF NOT EXISTS `campaign_report_household_map` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `campaign_report_map_id` INT UNSIGNED NOT NULL ,
  `household_id` INT NOT NULL ,
  `report_file` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_campaign_report_household_map_campaign_report_map (`campaign_report_map_id` ASC) ,
  INDEX fk_crhm_hh (`household_id` ASC) ,
  CONSTRAINT `fk_campaign_report_household_map_campaign_report_map`
    FOREIGN KEY (`campaign_report_map_id` )
    REFERENCES `campaign_report_map` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_crhm_hh`
    FOREIGN KEY (`household_id` )
    REFERENCES `household` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;"

execute "
CREATE  TABLE IF NOT EXISTS `user_property` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `user_id` INT(10) UNSIGNED NOT NULL ,
  `property_name` VARCHAR(50) NOT NULL ,
  `property_value` VARCHAR(250) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_user_property_user (`user_id` ASC) ,
  CONSTRAINT `fk_user_property_user`
    FOREIGN KEY (`user_id` )
    REFERENCES `broker`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;"
    
    execute "
ALTER TABLE `campaign` ADD COLUMN `user_id` INT(10) unsigned NOT NULL,
 ADD CONSTRAINT `fk_campaign_user` FOREIGN KEY `fk_campaign_user` (`user_id`)
    REFERENCES `user` (`id`) 
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;"
  end

  def self.down
    drop_table("user_property")
    drop_table("campaign_report_household_map")
    drop_table("campaign_report_map")
    drop_table("campaign_criteria")
    drop_table("campaign")
    drop_table("campaign_channel")
    drop_table("report_type")
  end
end
