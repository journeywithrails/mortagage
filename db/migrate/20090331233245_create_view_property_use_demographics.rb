class CreateViewPropertyUseDemographics < ActiveRecord::Migration
  def self.up
    execute "create view view_loan_origination_property_use as
  select
	  user_id,
	  property_use.name,
	  days,
	  count(*) as count
	from
	  loan,
	  property,
      property_use,
	  summary_day_ranges
	where
	  closing_date is not null and
	  closing_date>subdate(now(), interval `days` day) and
	  loan_status_id in (1,2) and
      loan.property_id = property.id and
	  property.property_use_id = property_use.id
	group by property_use.name, days, user_id"

   execute "create view view_loan_origination_property_use_regional_network as
  select
	  mae_regional_network_id,
	  property_use.name,
	  days,
	  count(*) as count
	from
	  loan,
	  property,
      property_use,
	  summary_day_ranges
	where
	  closing_date is not null and
	  closing_date>subdate(now(), interval `days` day) and
	  loan_status_id in (1,2) and
      loan.property_id = property.id and
	  property.property_use_id = property_use.id
	group by property_use.name, days, mae_regional_network_id"
  end

  def self.down
    execute "drop view view_loan_origination_property_use"
    execute "drop view view_loan_origination_property_use_regional_network"
  end
end
