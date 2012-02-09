class CleanUpViewLoanPortfolio < ActiveRecord::Migration
  def self.up

    
    execute "drop view if exists view_latest_household_income"
    execute "drop view if exists view_repeat_households"
    execute "drop view if exists view_repeat_households_aux"
    execute "drop view if exists view_loan_portfolio"

    execute "create view view_latest_household_income as

    select household_id, sum((select base_income_in_cents + overtime_in_cents + bonuses_in_cents + commissions_in_cents + net_rental_income_in_cents + other_income_in_cents from person_financial pf where date is not null and pf.person_id = person.id order by date desc limit 1)) as total_hh_income_in_cents from person group by household_id;"



    execute "create view view_repeat_households_aux as select household_id, closing_date, count(*) as loans_closed_on_this_date from loan, property where property_id = property.id group by household_id, closing_date"

      execute "create view view_repeat_households as select household_id from view_repeat_households_aux group by household_id having count(*)>1"

    execute "create view view_loan_portfolio as select
      user_id,
      count(*) as closed_loans,
      count(distinct(household_id)) active_loan_households,
      avg(datediff(now(),closing_date)/30.25) as average_loan_age_in_months,
      (select avg(total_hh_income_in_cents) from view_latest_household_income where household_id in (select id from household where user_id = loan.user_id)) as avg_hh_income_in_cents,
      avg((select (to_days(now()) - ((to_days(min_dob)+to_days(max_dob))/2))/365 from person where id = borrower_person_id)) as avg_borrower_age_in_years,
      avg((select (to_days(now()) - ((to_days(min_dob)+to_days(max_dob))/2))/365 from person where id = co_borrower_person_id)) as avg_co_borrower_age_in_years,
      (select count(*) from view_repeat_households where household_id in (select id from household where user_id = loan.user_id)) as repeat_households
    from
      loan,
      property 
    where
      loan_status_id=1 and
      loan.property_id = property.id 
    group by user_id;"




    execute "DROP VIEW IF EXISTS `view_estimated_person_income`"

    execute "DROP VIEW IF EXISTS  `view_active_loans_and_household`"
    
    execute "DROP VIEW IF EXISTS  `view_avg_borrower_age`"

    execute "DROP VIEW IF EXISTS `view_avg_co_borrower_age`"

  end

  def self.down


    execute "drop view if exists view_loan_portfolio"
    execute "drop view if exists view_latest_household_income"

    execute "drop view if exists view_repeat_households"
    execute "drop view if exists view_repeat_households_aux"

    execute "CREATE VIEW `view_loan_portfolio` AS select `view_active_loans_and_household`.`user_id` AS `user_id`,`view_active_loans_and_household`.`no_of_active_loans` AS `no_of_active_loans`,`view_active_loans_and_household`.`no_of_households` AS `no_of_households`,round((`view_active_loans_and_household`.`no_of_active_loans` / `view_active_loans_and_household`.`no_of_households`),0) AS `avg_loans_per_hh`,`view_active_loans_and_household`.`avg_loan_age` AS `avg_loan_age`,`view_active_loans_and_household`.`repeat_clients` AS `repeat_clients`,(select avg(`view_estimated_person_income`.`estimated_income_in_cents`) AS `avg(estimated_income_in_cents)` from `view_estimated_person_income` where (`view_active_loans_and_household`.`user_id` = `view_estimated_person_income`.`user_id`)) AS `avg_hh_income_in_cents`,concat((select round(avg(`view_avg_borrower_age`.`age`),0) AS `round(avg(age))` from`view_avg_borrower_age` where (`view_active_loans_and_household`.`user_id` = `view_avg_borrower_age`.`user_id`)),_utf8' / ',(select round(avg(`view_avg_co_borrower_age`.`age`),0) AS `round(avg(age))` from `view_avg_co_borrower_age` where (`view_active_loans_and_household`.`user_id` = `view_avg_co_borrower_age`.`user_id`))) AS `avg_ages` from `view_active_loans_and_household` group by `view_active_loans_and_household`.`user_id`;"

    execute "CREATE VIEW `view_estimated_person_income` AS select `loan`.`user_id` AS `user_id`,`household`.`id` AS `id`,`household_financial`.`estimated_income_in_cents` AS `estimated_income_in_cents` from ((`loan` join `household`) join`household_financial`) where ((`loan`.`borrower_person_id` = `household`.`head_of_hh_person_id`) and (`household`.`id` = `household_financial`.`household_id`) and (`loan`.`is_active` = 1)) group by `loan`.`user_id`,`loan`.`borrower_person_id`"

    execute "CREATE VIEW `view_active_loans_and_household` AS select `loan`.`user_id` AS `user_id`,count(0) AS `no_of_active_loans`,round(avg((`loan`.`loan_term_periods` / 12)),0) AS `avg_loan_age`,(((count(0) - count(distinct `loan`.`borrower_person_id`)) / count(0)) * 100) AS `repeat_clients`,(select count(0) AS `count(*)` from (`household`join `loan`) where ((`loan`.`borrower_person_id` = `household`.`head_of_hh_person_id`) and (`loan`.`is_active` = 1))) AS `no_of_households` from `loan` where (`loan`.`is_active` = 1) group by `loan`.`user_id`"
    
    execute "CREATE VIEW `view_avg_borrower_age` AS select `loan`.`user_id` AS `user_id`,`loan`.`borrower_person_id` AS `borrower_person_id`,round(((to_days(curdate()) - to_days(`person`.`max_dob`)) / 365),0) AS `age` from (`loan` join `person` on((`loan`.`borrower_person_id` = `person`.`id`))) group by `loan`.`user_id`,`loan`.`borrower_person_id`"

    execute "CREATE  VIEW`view_avg_co_borrower_age` AS select `loan`.`user_id` AS `user_id`,`loan`.`co_borrower_person_id` AS `co_borrower_person_id`,round(((to_days(curdate()) - to_days(`person`.`max_dob`)) / 365),0) AS `age` from (`loan` join `person` on((`loan`.`co_borrower_person_id` = `person`.`id`))) group by `loan`.`user_id`,`loan`.`co_borrower_person_id`"

end

end
