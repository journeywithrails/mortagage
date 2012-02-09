class CreateViewTopZipCodes < ActiveRecord::Migration
  def self.up
    execute "create or replace view view_top_zip_code as 
SELECT loan.user_id, count( * ) AS no_of_borrowers, person.zip
FROM loan
INNER JOIN person ON loan.borrower_person_id = person.id
WHERE loan.closing_date >= DATE_ADD( current_date, INTERVAL -365
DAY )
AND loan.closing_date <= current_date
GROUP BY zip
ORDER BY no_of_borrowers DESC"
  end

  def self.down
   execute "drop view view_top_zip_code"
  end
end
