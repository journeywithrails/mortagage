class CreateViewNewClients < ActiveRecord::Migration
  def self.up
    execute"create or replace view view_new_client as
SELECT l1.user_id, (count(distinct borrower_person_id)/count(*)*100) AS new_clients ,
(SELECT (count(distinct borrower_person_id)/count(*)*100) FROM loan l2
WHERE l2.closing_date >= DATE_ADD( current_date, INTERVAL -365 DAY )
AND l2.closing_date <= current_date AND l1.user_id = l2.user_id
GROUP BY l2.user_id) AS new_clients_last_year,
 (SELECT (count(distinct borrower_person_id)/count(*)*100) FROM loan l3
 WHERE l3.closing_date >= DATE_ADD( current_date, INTERVAL -180 DAY )
AND l3.closing_date <= current_date and l1.user_id = l3.user_id
GROUP BY l3.user_id
) AS new_clients_last_hyear,
(SELECT view_mae_regional_network.total_clients
FROM view_mae_regional_network
INNER JOIN user ON user.state = view_mae_regional_network.state where view_mae_regional_network.user_id = l1.user_id limit 1) as mae_regional_network
FROM loan l1
GROUP BY user_id"
  end

  def self.down
       execute "drop view view_new_client"
  end
end
