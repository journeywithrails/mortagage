class ChangeCommissionViews < ActiveRecord::Migration
  def self.up


      execute "drop view if exists view_loan_origination_performance_commission;"
      execute "drop view if exists view_loan_origination_performance_commission_regional_network;"
      execute "create view view_loan_origination_performance_commission as 
	  select
	    user_id,
	    days,
	    avg(commission_in_cents) as avg_commission_in_cents,
	    avg(commission_in_cents / loan_amount_in_cents * 100) as avg_pct_commission
	  from
	    loan, 	  
	    summary_day_ranges
	  where
	    closing_date is not null and
	    closing_date>subdate(now(), interval `days` day) and
	    loan_status_id in (1,2) and
	    commission_in_cents / loan_amount_in_cents * 100 < 20 and
	    commission_in_cents > 0
	  group by days, user_id;"


      execute "create view view_loan_origination_performance_commission_regional_network as 
	  select
	    mae_regional_network_id,
	    days,
	    avg(commission_in_cents) as avg_commission_in_cents,
	    avg(commission_in_cents / loan_amount_in_cents * 100) as avg_pct_commission
	  from
	    loan, 	  
	    summary_day_ranges
	  where
	    closing_date is not null and
	    closing_date>subdate(now(), interval `days` day) and
	    loan_status_id in (1,2) and
	    commission_in_cents / loan_amount_in_cents * 100 < 20 and
	    commission_in_cents > 0
	  group by days, mae_regional_network_id;"

  end

  def self.down

      execute "drop view if exists view_loan_origination_performance_commission;"
      execute "drop view if exists view_loan_origination_performance_commission_regional_network;"



    execute "create view view_loan_origination_performance_commission as 
	select
	  user_id,
	  loan_type.name,
	  days,
	  avg(commission_in_cents) as avg_commission_in_cents,
	  avg(commission_in_cents / loan_amount_in_cents * 100) as avg_pct_commission
	from
	  loan, 
	  loan_type,
	  summary_day_ranges
	where
	  loan.loan_type_id = loan_type.id and
	  closing_date is not null and
	  closing_date>subdate(now(), interval `days` day) and
	  loan_status_id in (1,2) and
	  commission_in_cents / loan_amount_in_cents * 100 < 20 and
	  commission_in_cents > 0
	group by loan_type.name, days, user_id;"

  

    execute "create view view_loan_origination_performance_commission_regional_network as 
	select
	  mae_regional_network_id,
	  loan_type.name,
	  days,
	  avg(commission_in_cents) as avg_commission_in_cents,
	  avg(commission_in_cents / loan_amount_in_cents * 100) as avg_pct_commission
	from
	  loan, 
	  loan_type,
	  summary_day_ranges
	where
	  loan.loan_type_id = loan_type.id and
	  closing_date is not null and
	  closing_date>subdate(now(), interval `days` day) and
	  loan_status_id in (1,2) and
	  commission_in_cents / loan_amount_in_cents * 100 < 20 and
	  commission_in_cents > 0
	group by loan_type.name, days, mae_regional_network_id;"

  
  end
end
