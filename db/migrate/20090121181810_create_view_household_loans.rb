class CreateViewHouseholdLoans < ActiveRecord::Migration
  def self.up
    execute "drop view if exists view_household_loan"
    execute "drop table if exists view_household_loan"
    
    execute "CREATE TABLE view_household_loan ( 
   id INT(11) NOT NULL, 
   user_id INT(10) UNSIGNED NOT NULL, 
   account_id INT(10) UNSIGNED NOT NULL, 
   head_of_hh_person_id INT(11) NULL, 
   is_dirty tinyint(1) NULL, 
   mae_index int(11) NULL,
   refi_scenario_id int(11) NULL,
   household_name varchar(100) NULL,
   street_name varchar(255) NULL,
   city varchar(45) NULL,
   zip varchar(15) NULL,
   available_equity int(11) NULL,
   property_count int(11) NULL,
   purchase_price_in_cents decimal(20, 2) NULL,
   property_type varchar(45) NULL,
   occupancy_type varchar(45) NULL,
   loan_size decimal(20, 2) NULL,
   ci_rate float NULL,
   max_loan_to_value_percent int(11) NULL,
   paymant_savings int(11) NULL,
   loan_date date NULL,
   next_arm_date date NULL,
   end_of_intrest_only_period date NULL, 
   balloon_payment_date date NULL,
   loan_type varchar(45) NULL,
   monthly_hh_income int(11) NULL,
   consumer_debts decimal(32,0) NULL,
   median_credit_score int(11) NULL,
   min_dob date NULL,
   max_dob date NULL,
   exact_dob date NULL
   ) ENGINE=InnoDB DEFAULT CHARSET=utf8;"
   
  end

  def self.down
    execute "drop table view_household_loan"
  end
end
