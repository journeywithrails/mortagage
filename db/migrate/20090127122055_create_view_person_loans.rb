class CreateViewPersonLoans < ActiveRecord::Migration
  def self.up
   execute "create or replace view view_person_loan as 
SELECT loan.id as id, loan.user_id, concat( person.last_name, ' ', person.first_name ) AS top_customer, count( * ) AS no_of_loans, sum(loan_amount_in_cents) as total_loans_in_cents
FROM loan
INNER JOIN person ON loan.borrower_person_id = person.id
GROUP BY top_customer
ORDER BY total_loans_in_cents DESC"
  end

  def self.down
    execute "drop view view_person_loan"
  end
end
