class AddFieldsToNewLoanProduct < ActiveRecord::Migration
  def self.up

    execute "alter table new_loan_product add term int not null default 360, add fixed_term int not null default 360, add is_fixed_rate tinyint not null default 1, add is_jumbo tinyint not null default 0, add is_interest_only tinyint not null default 0;"

    execute "update new_loan_product set term=360, fixed_term=360;"

    execute "update new_loan_product set term=480, fixed_term=480 where name like '%40 Year%';"

    execute "update new_loan_product set term=180, fixed_term=180 where name like '%15 Year%';"

    execute "update new_loan_product set term=240, fixed_term=240 where name like '%20 Year%';"

    execute "update new_loan_product set is_jumbo=1 where name like '%JUMBO%';"

    execute "update new_loan_product set is_interest_only=1 where name like '%I/O%';"

    execute "update new_loan_product set is_fixed_rate=0 where name not like '%Fixed%';"

    execute "update new_loan_product set fixed_term=3*12 where name like '%3/1%';"

    execute "update new_loan_product set fixed_term=5*12 where name like '%5/1%';"

    execute "update new_loan_product set fixed_term=7*12 where name like '%7/1%';"

    execute "update new_loan_product set fixed_term=10*12 where name like '%10/1%';"

    execute "update new_loan_product set fixed_term=12 where name like '%1 Year%';"


  end

  def self.down

    execute "alter table new_loan_product drop term, drop fixed_term, drop is_fixed_rate, drop is_jumbo, drop is_interest_only;"


  end
end
