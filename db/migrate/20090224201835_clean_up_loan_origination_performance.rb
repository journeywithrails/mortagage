class CleanUpLoanOriginationPerformance < ActiveRecord::Migration
  def self.up

    execute "drop view if exists view_loan_type_arm;"

    execute "drop view if exists view_loan_type_fixed;"

    execute "drop view if exists view_loan_type_heloc;"

    execute "drop view if exists view_loan_type_other;"

    execute "create table summary_day_ranges (days int) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci;"

    execute "insert into summary_day_ranges (days) values (180) ,(365), (100000);"

    execute "create table mae_regional_network (id int not null primary key, name varchar(100)) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_general_ci;"

    execute "insert into mae_regional_network (id,name) values (1, 'Unassigned USA');"

    execute "ALTER TABLE `loan` ADD COLUMN `mae_regional_network_id` INT NULL DEFAULT NULL;"

    execute "ALTER TABLE `user` ADD COLUMN `mae_regional_network_id` INT NULL DEFAULT NULL;"

    execute "ALTER TABLE `loan` ADD CONSTRAINT `fk_loan_mae_regional_network` FOREIGN KEY `fk_loan_mae_regional_network` (`mae_regional_network_id`)
	REFERENCES `mae_regional_network` (`id`)
	ON DELETE SET NULL
	ON UPDATE CASCADE;"

    execute "ALTER TABLE `user` ADD CONSTRAINT `fk_user_mae_regional_network` FOREIGN KEY `fk_user_mae_regional_network` (`mae_regional_network_id`)
	REFERENCES `mae_regional_network` (`id`)
	ON DELETE SET NULL
	ON UPDATE CASCADE;"

    execute "update loan set mae_regional_network_id = 1;"

    execute "update user set mae_regional_network_id = 1;"

    execute "create view view_loan_origination_performance_summary as 
	select
	  user_id,
	  loan_type.name,
	  days,
	  count(*) as count,
	  avg(loan_amount_in_cents) as avg_loan_amount_in_cents,
	  avg(datediff(closing_date,open_date)) as days_to_close
	from
	  loan, 
	  loan_type,
	  summary_day_ranges
	where
	  loan.loan_type_id = loan_type.id and
	  closing_date is not null and
	  closing_date>subdate(now(), interval `days` day) and
	  loan_status_id in (1,2) and
	  datediff(closing_date,open_date) < 90 
	group by loan_type.name, days, user_id;"

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

    execute "create view view_loan_origination_performance_summary_regional_network as 
	select
	  mae_regional_network_id,
	  loan_type.name,
	  days,
	  count(*) as count,
	  avg(loan_amount_in_cents) as avg_loan_amount_in_cents,
	  avg(datediff(closing_date,open_date)) as days_to_close
	from
	  loan, 
	  loan_type,
	  summary_day_ranges
	where
	  loan.loan_type_id = loan_type.id and
	  closing_date is not null and
	  closing_date>subdate(now(), interval `days` day) and
	  loan_status_id in (1,2) and
	  datediff(closing_date,open_date) < 90 
	group by loan_type.name, days, mae_regional_network_id;"

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

  def self.down


      execute "drop view if exists view_loan_origination_performance_summary;"

      execute "drop view if exists view_loan_origination_performance_commission;"

      execute "drop view if exists view_loan_origination_performance_summary_regional_network;"

      execute "drop view if exists view_loan_origination_performance_commission_regional_network;"

      execute "alter table loan drop FOREIGN KEY `fk_loan_mae_regional_network`;"

      execute "alter table user drop FOREIGN KEY `fk_user_mae_regional_network`;"

      execute "alter table loan drop KEY `fk_loan_mae_regional_network`;"

      execute "alter table user drop KEY `fk_user_mae_regional_network`;"

      execute "alter table loan drop column mae_regional_network_id;"

      execute "alter table user drop column mae_regional_network_id;"

      execute "drop table summary_day_ranges;"

      execute "drop table mae_regional_network;"

  end
end
