class CreateViewAvgLoanSizes < ActiveRecord::Migration
  def self.up
    execute"create or replace view view_mae_regional_network as
SELECT avg(loan_amount_in_cents) as mae_regional_network, person.state as state, loan.user_id, count(*) as total_loans,
(count(distinct borrower_person_id)/count(*)*100) as total_clients
FROM loan 
inner JOIN person ON loan.borrower_person_id = person.id
WHERE loan.closing_date >= DATE_ADD( current_date, INTERVAL -180 DAY )
AND loan.closing_date <= current_date
group by person.state"

execute "create or replace view view_avg_loan_size as
SELECT l1.user_id, avg(loan_amount_in_cents) AS avg_loan_amount ,
(SELECT avg(loan_amount_in_cents) FROM loan l2
WHERE l2.closing_date >= DATE_ADD( current_date, INTERVAL -365 DAY )
AND l2.closing_date <= current_date AND l1.user_id = l2.user_id
GROUP BY l2.user_id) AS avg_amount_in_last_year,
 (SELECT avg(loan_amount_in_cents) FROM loan l3
 WHERE l3.closing_date >= DATE_ADD( current_date, INTERVAL -180 DAY )
AND l3.closing_date <= current_date and l1.user_id = l3.user_id
GROUP BY l3.user_id
) AS avg_amount_in_last_hyear,
(SELECT view_mae_regional_network.mae_regional_network
FROM view_mae_regional_network
INNER JOIN user ON user.state = view_mae_regional_network.state where view_mae_regional_network.user_id = l1.user_id limit 1) as mae_regional_network
FROM loan l1
GROUP BY user_id"
  end

  def self.down
   execute "drop view view_mae_regional_network"
   execute "drop view view_avg_loan_size"
  end
end
