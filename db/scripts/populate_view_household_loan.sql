INSERT INTO view_household_loan ( 
  id,
  user_id,
  account_id,
  head_of_hh_person_id,
  is_dirty,
  mae_index,
  refi_scenario_id,
  household_name,
  street_name,
  city,
  zip,
  available_equity,
  property_count,
  purchase_price_in_cents,
  property_type,
  occupancy_type,
  loan_size,
  ci_rate,
  max_loan_to_value_percent,
  paymant_savings,
  loan_date,
  next_arm_date,
  end_of_intrest_only_period,
  balloon_payment_date,
  loan_type,
  monthly_hh_income,
  consumer_debts,
  median_credit_score,
  min_dob,
  max_dob,
  exact_dob
)
SELECT
  household.id,
  household.user_id,
  household.account_id,
  household.head_of_hh_person_id,
  household.is_dirty,
  household.mae_index,
  household.refi_scenario_id,
  concat(coalesce(person.last_name, ''),', ', coalesce(person.first_name, '')) as household_name,
  concat(coalesce(property.address1, ''), ' ', coalesce(property.address2, '')) as street_name,
  property.city,
  property.zip,
  refi_scenario.total_equity_in_cents as available_equity,
  view_household_property_count.property_count,
  property.purchase_price_in_cents,
  housing_type.name as property_type,
  property_use.name as occupancy_type,
  loan.loan_amount_in_cents as loan_size,
  refi_loan.note_rate as ci_rate,
  loan.max_loan_to_value_percent,
  refi_scenario.net_monthly_payment_change_in_cents,
  Date_Add(loan.closing_date, INTERVAL -30 DAY) as loan_date,
  '2222-01-01' as next_arm_date,
  '2222-01-01' as end_of_intrest_only_period,
  loan.final_balloon_payment_date,
  loan_type.name as loan_type,
  view_latest_person_financial.base_income_in_cents,
  view_total_household_consumer_debt.unpaid_balance_in_cents,
  view_latest_person_financial.median_credit_score,
  person.min_dob,
  person.max_dob,
  person.exact_dob
FROM 
  household
  INNER JOIN person on household.head_of_hh_person_id = person.id
  INNER JOIN loan on (loan.borrower_person_id = household.head_of_hh_person_id
		  or loan.co_borrower_person_id = household.head_of_hh_person_id)
  INNER JOIN property on property.id = loan.property_id
  LEFT OUTER JOIN view_latest_person_financial on person.id = view_latest_person_financial.person_id
  LEFT OUTER JOIN view_household_property_count on household.id = view_household_property_count.household_id
  LEFT OUTER JOIN property_use on property.property_use_id = property_use.id
  LEFT OUTER JOIN loan_type on loan.loan_type_id = loan_type.id
  LEFT OUTER JOIN refi_scenario on refi_scenario.household_id = household.id
  LEFT OUTER JOIN view_total_household_consumer_debt on view_total_household_consumer_debt.household_id = household.id
  LEFT OUTER JOIN housing_type on property.housing_type_id = housing_type.id
  LEFT OUTER JOIN refi_property on refi_property.property_id = property.id and refi_property.refi_scenario_id = refi_scenario.id
  LEFT OUTER JOIN refi_loan on refi_loan.refi_property_id = refi_property.id
WHERE
  refi_scenario.is_base_Case=1