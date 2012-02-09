class CreateViewLoanPortfolios < ActiveRecord::Migration
  def self.up
   execute "create or replace view view_active_loans_and_household as 
SELECT user_id, count(*) as no_of_active_loans, round( avg(loan_term_periods /12) ) as avg_loan_age,
(count(*)-count(distinct borrower_person_id))/(count(*))*100 as repeat_clients,  
(select count(*) from household, loan where 
loan.borrower_person_id = household.head_of_hh_person_id and is_active = 1) as no_of_households
FROM loan WHERE is_active = 1 group by user_id"

execute "CREATE OR REPLACE VIEW view_estimated_person_income AS
SELECT loan.user_id, household.id, household_financial.estimated_income_in_cents
FROM loan, household, `household_financial`
WHERE loan.borrower_person_id = household.head_of_hh_person_id
AND household.id = household_financial.household_id
AND is_active =1
GROUP BY loan.user_id, loan.borrower_person_id"


execute "create or replace view view_avg_borrower_age as
SELECT loan.user_id, loan.borrower_person_id, round( datediff( current_date, person.max_dob ) /365 ) AS age
FROM `loan`
INNER JOIN person ON loan.borrower_person_id = person.id
GROUP BY loan.user_id, loan.borrower_person_id"


execute "create or replace view view_avg_co_borrower_age as 
SELECT loan.user_id, loan.co_borrower_person_id, round( datediff( current_date, person.max_dob ) /365 ) AS age
FROM loan
INNER JOIN person ON loan.co_borrower_person_id = person.id
GROUP BY loan.user_id, loan.co_borrower_person_id"


execute "create or replace view view_loan_portfolio as
SELECT view_active_loans_and_household.user_id, no_of_active_loans, no_of_households, round( no_of_active_loans / no_of_households ) AS avg_loans_per_hh, avg_loan_age, repeat_clients,
(select avg(estimated_income_in_cents) from view_estimated_person_income where view_active_loans_and_household.user_id = view_estimated_person_income.user_id) as avg_hh_income_in_cents ,
concat((select round(avg(age)) from view_avg_borrower_age where view_active_loans_and_household.user_id = view_avg_borrower_age.user_id ), ' / ', 
(select round(avg(age)) from view_avg_co_borrower_age where view_active_loans_and_household.user_id = view_avg_co_borrower_age.user_id )) as avg_ages
FROM view_active_loans_and_household group by view_active_loans_and_household.user_id"
  end

  def self.down
    execute "drop view view_active_loans_and_household"
    execute "drop view view_estimated_person_income"
    execute "drop view view_avg_borrower_age"
    execute "drop view view_avg_co_borrower_age"
    execute "drop view view_loan_portfolio"
  end
end
