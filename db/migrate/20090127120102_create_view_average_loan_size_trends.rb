class CreateViewAverageLoanSizeTrends < ActiveRecord::Migration
  def self.up
  execute "create or replace view view_average_loan_size_trend as 
SELECT user_id, avg(loan_amount_in_cents) as average_loan_amount_in_cents, concat( monthname( `loan`.`closing_date` ) , ' - ', date_format( closing_date, '%Y' ) ) AS period
FROM `loan` inner join loan_status on loan.loan_status_id = loan_status.id and loan_status.status_name ='Closed'
GROUP BY user_id, year( closing_date), month( closing_date ) order by closing_date"
  end

  def self.down
    execute "drop view view_average_loan_size_trend"
  end
end
