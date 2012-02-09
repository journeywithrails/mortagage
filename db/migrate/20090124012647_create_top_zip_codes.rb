class CreateTopZipCodes < ActiveRecord::Migration
  def self.up
    execute "create or replace view top_zip_codes as SELECT count( * ) AS no_of_borrowers, zip
FROM person
INNER JOIN household ON person.household_id = household.head_of_hh_person_id
INNER JOIN loan ON household.head_of_hh_person_id = loan.borrower_person_id
WHERE loan.closing_date > DATE_ADD( current_date, INTERVAL -365
DAY )
AND loan.closing_date < current_date
GROUP BY zip"
  end

  def self.down
   
  end
end
