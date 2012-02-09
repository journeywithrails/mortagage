class CreateTransactionsTrends < ActiveRecord::Migration
  def self.up
    execute "CREATE OR REPLACE VIEW transactions_trends AS
SELECT count( * ) AS transactions , concat( monthname( amortization_schedule.period_start_date ) , ' - ', date_format( period_start_date, '%y' ) ) AS period
FROM amortization_schedule 
inner join loan on loan_id = loan.id 
inner join loan_status on loan.loan_status_id = loan_status.id and status_name = 'Closed'
GROUP BY Year( period_start_date ) , Month( period_start_date )
ORDER BY amortization_schedule.period_start_date  "
   
  end

  def self.down
    
  end
end
