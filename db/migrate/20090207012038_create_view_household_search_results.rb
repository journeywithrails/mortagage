class CreateViewHouseholdSearchResults < ActiveRecord::Migration
  def self.up
    execute "drop view IF EXISTS view_household_loan_search_result;"
    execute "drop view IF EXISTS view_household_search_result;"

    execute "CREATE TABLE `view_household_loan_search_result` ( `id` INT(11)
   NOT NULL, `user_id` INT(10) UNSIGNED NOT NULL, `household_name`
   varchar(100), `property_count` int, `total_loans_in_cents`
   decimal(20), `avg_loan_size_in_cents` decimal(20), `avg_ltv`
   decimal, total_monthly_payments_in_cents decimal(20), PRIMARY KEY (id)
   ) ENGINE=InnoDB DEFAULT CHARSET=utf8;"
   
execute "CREATE OR REPLACE VIEW view_household_monthly_payment AS
SELECT household.id, property.household_id, refi_property.id AS refi_property_id, refi_loan.monthly_payment_in_cents
FROM household
LEFT OUTER JOIN property ON household.id = property.household_id
LEFT OUTER JOIN refi_property ON refi_property.property_id = property.id
LEFT OUTER JOIN refi_loan ON refi_loan.refi_property_id = refi_property.id
LEFT OUTER JOIN refi_scenario ON refi_scenario.id = refi_property.refi_scenario_id
AND refi_scenario.is_base_case =1 group by household.id"

  end

  def self.down
    execute "drop table view_household_loan_search_result"
  end
end
