class CreateViewHouseholdPropertyCount < ActiveRecord::Migration
  def self.up
    execute "create or replace view view_household_property_count as 
select 
  household.id as household_id, 
  count(*) as property_count 
from 
household 
left outer join person on household.head_of_hh_person_id = person.id 
left outer join loan on loan.borrower_person_id = person.id 
group by household.id;"
  end

  def self.down
    execute "drop view view_household_property_count"
  end
end
