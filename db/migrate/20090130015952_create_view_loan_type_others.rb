class CreateViewLoanTypeOthers < ActiveRecord::Migration
  def self.up
    execute "create or replace view view_other as 
SELECT loan.user_id, person.state as state, 
count(loan_type_id) as other
FROM loan 
inner JOIN person ON loan.borrower_person_id = person.id
inner join loan_type on loan.loan_type_id = loan_type.id
WHERE loan.closing_date >= DATE_ADD( current_date, INTERVAL -180 DAY )
AND loan.closing_date <= current_date and loan_type.name = 'Other Loan'
group by person.state"

execute "create or replace view view_loan_type_other as
SELECT l1.user_id, (select count(loan_type_id) from loan inner join loan_type on loan.loan_type_id = loan_type.id where loan_type.name = 'Other Loan')/count(*)*100 as other,
(SELECT (select count(loan_type_id) from loan inner join loan_type on loan.loan_type_id = loan_type.id where loan_type.name = 'Other Loan')/count(*)*100 FROM loan l2
WHERE l2.closing_date >= DATE_ADD( current_date, INTERVAL -365 DAY )
AND l2.closing_date <= current_date AND l1.user_id = l2.user_id
GROUP BY l2.user_id) AS other_last_year,
 (SELECT (select count(loan_type_id) from loan inner join loan_type on loan.loan_type_id = loan_type.id where loan_type.name = 'Other Loan')/count(*)*100 FROM loan l3
 WHERE l3.closing_date >= DATE_ADD( current_date, INTERVAL -180 DAY )
AND l3.closing_date <= current_date and l1.user_id = l3.user_id
GROUP BY l3.user_id
) AS other_last_hyear,
((SELECT view_other.other
FROM view_other
INNER JOIN user ON user.state =view_other.state where view_other.user_id = l1.user_id limit 1)/count(*)*100) as mae_regional_network
FROM loan l1
GROUP BY user_id"
  end

  def self.down
    execute "drop view view_other"
    execute "drop view view_loan_type_other"
  end
end
