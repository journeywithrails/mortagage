class CreateNewLoanProductTables < ActiveRecord::Migration
  def self.up
    execute "
CREATE  TABLE IF NOT EXISTS `new_loan_product_capture` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `date_captured` DATE NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;"

    execute "
CREATE  TABLE IF NOT EXISTS `new_loan_product` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(150) NOT NULL ,
  `lock_days` INT(11) NOT NULL ,
  `margin_rate` FLOAT NULL ,
  `index_rate` FLOAT NULL ,
  `initial_cap` FLOAT NULL ,
  `periodic_cap` FLOAT NULL ,
  `lifetime_cap` FLOAT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX unique_test (`name` ASC, `margin_rate` ASC, `lock_days` ASC, `index_rate` ASC, `initial_cap` ASC, `periodic_cap` ASC, `lifetime_cap` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;"

    execute "
CREATE  TABLE IF NOT EXISTS `new_loan_product_fico_ltv_adjustment` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `loan_term_gt_15_yrs` BOOLEAN NOT NULL ,
  `cash_out_refi` BOOLEAN NOT NULL ,
  `expanded_approval` BOOLEAN NOT NULL ,
  `min_ltv` FLOAT NOT NULL ,
  `max_ltv` FLOAT NOT NULL ,
  `min_fico` INT(11) NOT NULL ,
  `max_fico` INT(11) NOT NULL ,
  `adjustor` FLOAT NULL ,
  `new_loan_product_capture_id` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_new_loan_product_fico_ltv_adjustment_new_loan_product_capture (`new_loan_product_capture_id` ASC) ,
  CONSTRAINT `fk_new_loan_product_fico_ltv_adjustment_new_loan_product_capture`
    FOREIGN KEY (`new_loan_product_capture_id` )
    REFERENCES `new_loan_product_capture` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;"

    execute "
CREATE  TABLE IF NOT EXISTS `new_loan_product_rate_margin` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `new_loan_product_id` INT(11) NOT NULL ,
  `new_loan_product_capture_id` INT(11) NOT NULL ,
  `rate` FLOAT NOT NULL ,
  `broker_margin` FLOAT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX fk_new_loan_rate_margin_new_loan_product (`new_loan_product_id` ASC) ,
  INDEX fk_new_loan_rate_margin_new_loan_product_capture (`new_loan_product_capture_id` ASC) ,
  CONSTRAINT `fk_new_loan_rate_margin_new_loan_product`
    FOREIGN KEY (`new_loan_product_id` )
    REFERENCES `new_loan_product` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_new_loan_rate_margin_new_loan_product_capture`
    FOREIGN KEY (`new_loan_product_capture_id` )
    REFERENCES `new_loan_product_capture` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;"
  end

  def self.down
  end
end
