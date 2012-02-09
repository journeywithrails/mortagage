class FutureRatesAndCreditors < ActiveRecord::Migration
  def self.up
    execute "
    CREATE  TABLE IF NOT EXISTS `creditor` (
      `id` INT(11) NOT NULL AUTO_INCREMENT ,
      `loan_id` INT(11) NULL DEFAULT NULL ,
      `name` VARCHAR(45) NULL DEFAULT NULL ,
      `creditor_type` VARCHAR(5) NULL DEFAULT NULL ,
      `to_be_paid_off` BOOLEAN NULL ,
      `unpaid_balance_in_cents` INT(11) NULL DEFAULT NULL ,
      `monthly_payment_in_cents` INT(11) NULL DEFAULT NULL ,
      `months_left` INT(11) NULL DEFAULT NULL ,
      INDEX fk_creditor_loan (`loan_id` ASC) ,
      PRIMARY KEY (`id`) ,
      CONSTRAINT `fk_creditor_loan`
        FOREIGN KEY (`loan_id` )
        REFERENCES `loan` (`id` )
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8
    COLLATE = utf8_general_ci;"

    execute "
    CREATE  TABLE IF NOT EXISTS `future_rate` (
      `id` INT(11) NOT NULL AUTO_INCREMENT ,
      `name` VARCHAR(45) NULL DEFAULT NULL ,
      PRIMARY KEY (`id`) )
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8
    COLLATE = utf8_general_ci;"

    execute "
    CREATE  TABLE IF NOT EXISTS `future_rate_capture` (
      `id` INT(11) NOT NULL AUTO_INCREMENT ,
      `date_captured` DATE NULL ,
      `future_rate_id` INT(11) NULL DEFAULT NULL ,
      PRIMARY KEY (`id`) ,
      INDEX fk_future_rate_capture_future_rate (`future_rate_id` ASC) ,
      CONSTRAINT `fk_future_rate_capture_future_rate`
        FOREIGN KEY (`future_rate_id` )
        REFERENCES `future_rate` (`id` )
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8
    COLLATE = utf8_general_ci;"
    
    execute "
    CREATE  TABLE IF NOT EXISTS `future_rate_period` (
      `id` INT(11) NOT NULL AUTO_INCREMENT ,
      `date` DATE NULL ,
      `interest_rate` FLOAT NULL ,
      `future_rate_capture_id` INT(11) NULL DEFAULT NULL ,
      PRIMARY KEY (`id`) ,
      INDEX ix_future_rate_date (`date` ASC, `future_rate_capture_id` ASC) ,
      INDEX fk_future_rate_period_future_rate_capture (`future_rate_capture_id` ASC) ,
      CONSTRAINT `fk_future_rate_period_future_rate_capture`
        FOREIGN KEY (`future_rate_capture_id` )
        REFERENCES `future_rate_capture` (`id` )
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8
    COLLATE = utf8_general_ci;"

    execute "
    ALTER TABLE `rate` ADD COLUMN `future_rate_id` INT(11) NULL DEFAULT NULL  AFTER `fmae_index_type` , ADD CONSTRAINT `fk_rate_future_rate`
      FOREIGN KEY (`future_rate_id` )
      REFERENCES `future_rate` (`id` )
      ON DELETE NO ACTION;"

    execute "ALTER TABLE `zillow_cache` ADD COLUMN `failed_to_match` BOOLEAN NULL DEFAULT false  AFTER `last_sold_price` ;"
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
