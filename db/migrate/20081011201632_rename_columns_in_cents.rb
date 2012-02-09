class RenameColumnsInCents < ActiveRecord::Migration
  def self.up  
    execute "ALTER TABLE `closing_scenario` CHANGE COLUMN `origination_amount` `origination_amount_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `closing_scenario` CHANGE COLUMN `discount_amount` `discount_amount_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `closing_scenario` CHANGE COLUMN `application_fee` `application_fee_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `closing_scenario` CHANGE COLUMN `commitment_fee` `commitment_fee_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `closing_scenario` CHANGE COLUMN `appraisal` `appraisal_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `closing_scenario` CHANGE COLUMN `credit_report` `credit_report_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `closing_scenario` CHANGE COLUMN `document_preparation` `document_preparation_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `closing_scenario` CHANGE COLUMN `extension_fee` `extension_fee_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `closing_scenario` CHANGE COLUMN `flood_certificate` `flood_certificate_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `closing_scenario` CHANGE COLUMN `funding_fee` `funding_fee_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `closing_scenario` CHANGE COLUMN `postage` `postage_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `closing_scenario` CHANGE COLUMN `processing` `processing_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `closing_scenario` CHANGE COLUMN `service_fee` `service_fee_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `closing_scenario` CHANGE COLUMN `tax_service_amount` `tax_service_amount_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `closing_scenario` CHANGE COLUMN `underwriting` `underwriting_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `closing_scenario` CHANGE COLUMN `wire_transfer` `wire_transfer_in_cents` INTEGER DEFAULT NULL;"

    execute "ALTER TABLE `household_financial` CHANGE COLUMN `estimated_income` `estimated_income_in_cents` INTEGER DEFAULT NULL;"
    
    execute "ALTER TABLE `loan` CHANGE COLUMN `loan_amount` `loan_amount_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `loan` CHANGE COLUMN `final_balloon_payment` `final_balloon_payment_in_cents` INTEGER DEFAULT NULL;"

    execute "ALTER TABLE `property` CHANGE COLUMN `purchase_price` `purchase_price_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `property` CHANGE COLUMN `estimated_tax_amt` `estimated_tax_amt_in_cents` INTEGER DEFAULT NULL;"

    execute "ALTER TABLE `property_valuation` CHANGE COLUMN `value` `value_in_cents` INTEGER DEFAULT NULL;"

    execute "ALTER TABLE `proposal_scenario` CHANGE COLUMN `purchase_price` `purchase_price_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `proposal_scenario` CHANGE COLUMN `down_payment_amount` `down_payment_amount_in_cents` INTEGER DEFAULT NULL;"

    execute "ALTER TABLE `tax_rate` CHANGE COLUMN `top_income` `top_income_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `tax_rate` CHANGE COLUMN `base_tax` `base_tax_in_cents` INTEGER DEFAULT NULL;"

    execute "ALTER TABLE `title_fee_scenario` CHANGE COLUMN `settlement_fee` `settlement_fee_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `title_fee_scenario` CHANGE COLUMN `city_county_fee` `city_county_fee_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `title_fee_scenario` CHANGE COLUMN `closing` `closing_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `title_fee_scenario` CHANGE COLUMN `commitment` `commitment_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `title_fee_scenario` CHANGE COLUMN `endorsement` `endorsement_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `title_fee_scenario` CHANGE COLUMN `exam` `exam_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `title_fee_scenario` CHANGE COLUMN `lender_policy` `lender_policy_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `title_fee_scenario` CHANGE COLUMN `notary_fee` `notary_fee_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `title_fee_scenario` CHANGE COLUMN `owners_policy` `owners_policy_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `title_fee_scenario` CHANGE COLUMN `inspection` `inspection_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `title_fee_scenario` CHANGE COLUMN `recording_fee` `recording_fee_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `title_fee_scenario` CHANGE COLUMN `title_insurance` `title_insurance_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `title_fee_scenario` CHANGE COLUMN `title_search` `title_search_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `title_fee_scenario` CHANGE COLUMN `state_fee` `state_fee_in_cents` INTEGER DEFAULT NULL;"
    execute "ALTER TABLE `title_fee_scenario` CHANGE COLUMN `survey_fee` `survey_fee_in_cents` INTEGER DEFAULT NULL;"

    execute "ALTER TABLE `zillow_cache` CHANGE COLUMN `zestimate` `zestimate_in_cents` INTEGER DEFAULT NULL;"
  end

  def self.down
  end
end
