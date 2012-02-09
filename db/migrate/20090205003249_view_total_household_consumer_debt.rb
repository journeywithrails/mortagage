class ViewTotalHouseholdConsumerDebt < ActiveRecord::Migration
  def self.up
    execute "create or replace view view_total_household_consumer_debt as
select household.id as household_id, sum(creditor.unpaid_balance_in_cents) as unpaid_balance_in_cents
from household
inner join property on property.household_id = household.id
inner join loan on loan.property_id = property.id
inner join creditor on creditor.loan_id = loan.id
where creditor.creditor_type in ('L', 'R')
group by household.id;"
  end

  def self.down
    execute "drop view view_total_household_consumer_debt"
  end
end
