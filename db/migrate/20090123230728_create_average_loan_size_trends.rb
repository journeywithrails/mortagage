class CreateAverageLoanSizeTrends < ActiveRecord::Migration
  def self.up
   execute "create or replace view average_loan_size_trends as 
SELECT (avg(loan_amount_in_cents)/100) as average_loan_amount, concat( monthname( loan.closing_date ) , ' - ', date_format( closing_date, '%Y' ) ) AS period
FROM loan inner join loan_status on loan.loan_status_id = loan_status.id and loan_status.status_name ='Closed'
GROUP BY year( closing_date), month( closing_date ) order by closing_date"
    end


  def self.down
   
  end
end
