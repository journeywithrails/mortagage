class CreateViewTotalLoans < ActiveRecord::Migration
  def self.up
   execute"create or replace view view_total_loan as 
SELECT l1.user_id, count(*) AS total_loans ,
(SELECT count(*) FROM loan l2
WHERE l2.closing_date >= DATE_ADD( current_date, INTERVAL -365 DAY )
AND l2.closing_date <= current_date AND l1.user_id = l2.user_id
GROUP BY l2.user_id) AS total_loans_last_year,
 (SELECT count(*) FROM loan l3
 WHERE l3.closing_date >= DATE_ADD( current_date, INTERVAL -180 DAY )
AND l3.closing_date <= current_date and l1.user_id = l3.user_id
GROUP BY l3.user_id
) AS loans_in_last_hyear,
(SELECT view_mae_regional_network.total_loans
FROM view_mae_regional_network
INNER JOIN user ON user.state = view_mae_regional_network.state where view_mae_regional_network.user_id = l1.user_id limit 1) as mae_regional_network
FROM loan l1
GROUP BY user_id"
  end

  def self.down
     execute "drop view view_total_loan"
   
  end
end
