class CreateViewHouseholdPropertyDetails < ActiveRecord::Migration
  def self.up
    execute"create or replace view view_household_property_detail as
SELECT loan.id,loan.loan_amount_in_cents, loan.loan_due_in_periods, open_date as loan_date, refi_scenario.net_monthly_payment_change_in_cents, refi_scenario.total_monthly_payment_in_cents, refi_loan.note_rate as current_interest_rate, loan_type.name as loan_type, opportunity_type.name as opportunity_type, loan.is_active, loan_status.status_name, property_use.name, concat( coalesce( property.address1, '' ) , ' ', coalesce( property.address2, '' ) ) AS address,property.city, property.state, property.zip,  property.purchase_price_in_cents, loan.borrower_person_id, loan.co_borrower_person_id, property.household_id, property.id as property_id, household.best_mae_index, refi_scenario.total_equity_in_cents AS available_equity_in_cents, (SELECT sum( creditor.unpaid_balance_in_cents) FROM creditor, loan l2 WHERE creditor.loan_id = l2.id AND loan.id = l2.id GROUP BY l2.id ) AS consumer_debts_in_cents FROM loan inner join loan_type on loan.loan_type_id = loan_type.id inner join loan_status on loan.loan_status_id = loan_status.id INNER JOIN property ON loan.property_id = property.id INNER JOIN household ON property.household_id = household.id inner join property_use on property.property_use_id = property_use.id left outer join opportunity_type on household.best_opportunity_type_id = opportunity_type.id left outer join refi_property on refi_property.property_id = property.id left outer join refi_loan on refi_loan.refi_property_id = refi_property.id LEFT OUTER JOIN refi_scenario ON household.id = refi_scenario.household_id
order by loan_date desc"
  end

  def self.down
    execute "drop view view_household_property_detail"
  end
end