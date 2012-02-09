class UpdateChartViews < ActiveRecord::Migration
  def self.up
    execute "drop view if exists view_transactions_trend"
    execute "drop view if exists view_average_loan_size_trend"
    execute "drop view if exists view_top_zip_code"
    
    execute "CREATE view `view_transactions_trend` 
    AS select `user_id` AS `user_id`,
    count(0) AS `closed_loan_count`,
    avg(`loan_amount_in_cents`) AS `average_loan_amount_in_cents`,
    date_format(`closing_date`,_utf8'%b - %y') AS `period` 
    from loan
    where loan_status_id = 1
     group by 
    `user_id`,
    year(`closing_date`),
    month(`closing_date`)
     order by `closing_date` desc"
     
     execute "CREATE VIEW `view_top_zip_code` 
     AS select `loan`.`user_id` AS `user_id`,
      count(0) AS `no_of_borrowers`,
      `property`.`zip` AS `zip` 
      from `loan` 
      join `property` on `loan`.`property_id` = `property`.`id`
      where ((`loan`.`closing_date` >= (curdate() + interval -(2*365) day)) 
      and (`loan`.`closing_date` <= curdate())) 
      and loan.loan_status_id = 1
      group by loan.user_id, `property`.`zip` 
      order by count(0) desc"
  end

  def self.down
  end
end
