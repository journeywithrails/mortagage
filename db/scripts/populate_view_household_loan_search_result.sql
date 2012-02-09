INSERT INTO view_household_loan_search_result
(
  id,
  user_id,
  household_name,
  property_count,
  total_loans_in_cents,
  avg_loan_size_in_cents,
  avg_ltv,
  total_monthly_payments_in_cents
)

SELECT 
  household.id, 
  household.user_id, 
  concat( coalesce( person.last_name, '' ) , ', ', coalesce( person.first_name, '' ) ) AS household_name, 
  view_household_property_count.property_count, 
  sum( loan.loan_amount_in_cents ) AS total_loans_in_cents, 
  avg( loan.loan_amount_in_cents) AS avg_loan_size_in_cents, 
  avg(loan.max_loan_to_value_percent) AS avg_ltv, 
  coalesce(view_household_monthly_payment.monthly_payment_in_cents, 0.0000) as total_monthly_payments
FROM 
  household
  LEFT OUTER JOIN person ON household.head_of_hh_person_id = person.id
  LEFT OUTER JOIN view_household_property_count ON household.id = view_household_property_count.household_id
  INNER JOIN loan ON ( household.head_of_hh_person_id = loan.co_borrower_person_id
		  OR household.head_of_hh_person_id = loan.borrower_person_id )
  LEFT OUTER JOIN view_household_monthly_payment ON household.id = view_household_monthly_payment.household_id
GROUP BY 
  household.id