class FixViewPropertyReportImage < ActiveRecord::Migration
  def self.up
    execute "drop function `proper`" rescue nil

    execute <<-EOS
    CREATE  FUNCTION `proper`( str VARCHAR(128) ) RETURNS varchar(128) CHARSET latin1
    BEGIN
      DECLARE c CHAR(1);
      DECLARE s VARCHAR(128);
      DECLARE i INT DEFAULT 1;
      DECLARE bool INT DEFAULT 1;
      DECLARE punct CHAR(17) DEFAULT ' ()[]{},.-_!@;:?/';
      SET s = LCASE( str );
      WHILE i < LENGTH( str ) DO
        BEGIN
          SET c = SUBSTRING( s, i, 1 );
          IF LOCATE( c, punct ) > 0 THEN
            SET bool = 1;
          ELSEIF bool=1 THEN
            BEGIN
              IF c >= 'a' AND c <= 'z' THEN
                BEGIN
                  SET s = CONCAT(LEFT(s,i-1),UCASE(c),SUBSTRING(s,i+1));
                  SET bool = 0;
                END;
              ELSEIF c >= '0' AND c <= '9' THEN
                SET bool = 0;
              END IF;
            END;
          END IF;
          SET i = i+1;
        END;
      END WHILE;
      RETURN s;
    END
    EOS
    
    execute <<-EOS
    CREATE or replace VIEW `view_property_report` AS select _utf8'Refi' AS `imageid`,`proper`(`property`.`address1`) AS `prop_address1`,`proper`(`property`.`address2`) AS `prop_address2`,`proper`(`property`.`city`) AS `prop_city`,`property`.`state` AS `prop_state`,`property`.`zip` AS `prop_zip`,`property`.`purchase_price_in_cents` AS `prop_purchase_price`,`property`.`household_id` AS `prop_household_id`,`loan`.`borrower_person_id` AS `loan_borrower_person_id`,`amortization_schedule`.`period_start_date` AS `amort_period_start_date`,`amortization_schedule`.`principle` AS `amort_principal`,`amortization_schedule`.`remaining_bal` AS `amort_remaining_bal`,`amortization_schedule`.`interest` AS `amort_interest`,`amortization_schedule`.`rate` AS `amort_rate`,`loan`.`loan_type_id` AS `loan_type_id`,`loan`.`is_active` AS `loan_is_active`,`loan`.`loan_amount_in_cents` AS `loan_amount`,`loan`.`closing_date` AS `loan_closing_date`,`loan`.`loan_term_periods` AS `loan_term_periods`,`loan`.`first_payment_date` AS `loan_first_payment_date`,`loan_type`.`name` AS `loan_type_name`,`proper`(`person`.`first_name`) AS `person_first_name`,`proper`(`person`.`middle_name`) AS `person_middle_name`,`proper`(`person`.`last_name`) AS `person_last_name` from ((((`property` join `loan` on((`property`.`id` = `loan`.`property_id`))) join `amortization_schedule` on((`loan`.`id` = `amortization_schedule`.`loan_id`))) join `loan_type` on((`loan`.`loan_type_id` = `loan_type`.`id`))) join `person` on((`loan`.`borrower_person_id` = `person`.`id`)))
    EOS
    
    execute <<-EOS
    CREATE OR REPLACE VIEW `view_property_report_image` AS select `view_property_report`.`imageid` AS `imageid`,`view_property_report`.`prop_address1` AS `prop_address1`,`view_property_report`.`prop_address2` AS `prop_address2`,`view_property_report`.`prop_city` AS `prop_city`,`view_property_report`.`prop_state` AS `prop_state`,`view_property_report`.`prop_zip` AS `prop_zip`,`view_property_report`.`prop_purchase_price` AS `prop_purchase_price`,`view_property_report`.`prop_household_id` AS `prop_household_id`,`view_property_report`.`loan_borrower_person_id` AS `loan_borrower_person_id`,`view_property_report`.`amort_period_start_date` AS `amort_period_start_date`,`view_property_report`.`amort_principal` AS `amort_principal`,`view_property_report`.`amort_remaining_bal` AS `amort_remaining_bal`,`view_property_report`.`amort_interest` AS `amort_interest`,`view_property_report`.`amort_rate` AS `amort_rate`,`view_property_report`.`loan_type_id` AS `loan_type_id`,`view_property_report`.`loan_is_active` AS `loan_is_active`,`view_property_report`.`loan_amount` AS `loan_amount`,`view_property_report`.`loan_closing_date` AS `loan_closing_date`,`view_property_report`.`loan_term_periods` AS `loan_term_periods`,`view_property_report`.`loan_first_payment_date` AS `loan_first_payment_date`,`view_property_report`.`loan_type_name` AS `loan_type_name`,`view_property_report`.`person_first_name` AS `person_first_name`,`view_property_report`.`person_middle_name` AS `person_middle_name`,`view_property_report`.`person_last_name` AS `person_last_name`,`broker`.`images`.`id` AS `id`,`broker`.`images`.`image` AS `image`,`broker`.`images`.`caption` AS `caption`,`broker`.`images`.`image` AS `p_image` from (`view_property_report` join `images` on((`view_property_report`.`imageid` = `broker`.`images`.`caption`)))
    EOS
  end

  def self.down
  end
end
