class CreateHousholdReport < ActiveRecord::Migration
  def self.up
    execute("
      CREATE TABLE `broker`.`household_report` (
        `id` int unsigned NOT NULL AUTO_INCREMENT,
        `user_id` int unsigned NOT NULL,
        `household_id` int NOT NULL,
        `campaign_id` int unsigned ,
        `refi_scenario_id` int,
        `report_file` text  NOT NULL,
        `created_at` TIMESTAMP  NOT NULL,
        `expires_at` TIMESTAMP ,
        `opportunity_type_id` int NOT NULL,
        PRIMARY KEY (`id`),
        CONSTRAINT `fk_user__household_report` FOREIGN KEY `fk_user__household_report` (`user_id`)
          REFERENCES `user` (`id`)
          ON DELETE CASCADE
          ON UPDATE CASCADE,
        CONSTRAINT `fk_household__household_report` FOREIGN KEY `fk_household__household_report` (`household_id`)
          REFERENCES `household` (`id`)
          ON DELETE RESTRICT
          ON UPDATE RESTRICT,
        CONSTRAINT `fk_campaign_household_report` FOREIGN KEY `fk_campaign_household_report` (`campaign_id`)
          REFERENCES `campaign` (`id`)
          ON DELETE SET NULL
          ON UPDATE CASCADE,
        CONSTRAINT `fk_refi_scenario__household_report` FOREIGN KEY `fk_refi_scenario__household_report` (`refi_scenario_id`)
          REFERENCES `refi_scenario` (`id`)
          ON DELETE SET NULL
          ON UPDATE CASCADE,
        CONSTRAINT `fk_opportunity_type__household_report` FOREIGN KEY `fk_opportunity_type__household_report` (`opportunity_type_id`)
          REFERENCES `opportunity_type` (`id`)
          ON DELETE RESTRICT
          ON UPDATE CASCADE
      )
      ENGINE = InnoDB DEFAULT CHARSET=latin1;
    ")
    drop_table 'campaign_report_household_map' rescue nil
    drop_table 'campaign_report_map' rescue nil
    drop_table 'report_type' rescue nil
  end

  def self.down
    execute("
      CREATE TABLE `report_type` (
        `id` int(11) NOT NULL auto_increment,
        `name` varchar(80) NOT NULL,
        PRIMARY KEY  (`id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=latin1
    ")
    execute( "
      CREATE TABLE `campaign_report_map` (
        `id` int(10) unsigned NOT NULL auto_increment,
        `campaign_id` int(10) unsigned default NULL,
        `report_type_id` int(11) default NULL,
        PRIMARY KEY  (`id`),
        KEY `fk_campaign_report_map_campaign` (`campaign_id`),
        KEY `fk_campaign_report_map_report_type` (`report_type_id`),
        CONSTRAINT `fk_campaign_report_map_campaign` FOREIGN KEY (`campaign_id`) REFERENCES `campaign` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT `fk_campaign_report_map_report_type` FOREIGN KEY (`report_type_id`) REFERENCES `report_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
      ) ENGINE=InnoDB DEFAULT CHARSET=latin1
    ")
    execute( "
      CREATE TABLE `campaign_report_household_map` (
        `id` int(11) NOT NULL auto_increment,
        `campaign_report_map_id` int(10) unsigned NOT NULL,
        `household_id` int(11) NOT NULL,
        `report_file` varchar(255) default NULL,
        PRIMARY KEY  (`id`),
        KEY `fk_campaign_report_household_map_campaign_report_map` (`campaign_report_map_id`),
        KEY `fk_crhm_hh` (`household_id`),
        CONSTRAINT `fk_campaign_report_household_map_campaign_report_map` FOREIGN KEY (`campaign_report_map_id`) REFERENCES `campaign_report_map` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
        CONSTRAINT `fk_crhm_hh` FOREIGN KEY (`household_id`) REFERENCES `household` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
      ) ENGINE=InnoDB DEFAULT CHARSET=latin1
    ")
    drop_table 'household_report'
  end
end
