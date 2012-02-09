class CreateViewTransactionsTrends < ActiveRecord::Migration
  def self.up
   execute "CREATE OR REPLACE VIEW view_transactions_trend AS
   SELECT user_id, count( * ) AS closed_loan_count,
   concat( monthname( closing_date ) , ' - ', date_format(
   closing_date, '%y' ) ) AS period
   FROM loan
   inner join loan_status on loan.loan_status_id = loan_status.id
   and status_name = 'Closed'
   GROUP BY user_id, Year( closing_date ) , Month( closing_date )
   ORDER BY closing_date"
    end

  def self.down
   execute "drop view view_transactions_trend"
  end
end
