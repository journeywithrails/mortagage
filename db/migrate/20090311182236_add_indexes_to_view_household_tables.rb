class AddIndexesToViewHouseholdTables < ActiveRecord::Migration
  def self.up
    add_index :view_household_loan, :id
    add_index :view_household_loan, :user_id
    add_index :view_household_loan, :household_name
    add_index :view_household_loan, :street_name
    add_index :view_household_loan, :city
    add_index :view_household_loan, :zip                          
    add_index :view_household_loan, :available_equity_in_cents      
    add_index :view_household_loan, :property_count               
    add_index :view_household_loan, :purchase_price_in_cents       
    add_index :view_household_loan, :property_type_id             
    add_index :view_household_loan, :occupancy_type_id           
    add_index :view_household_loan, :current_loan_amount_in_cents 
    add_index :view_household_loan, :current_interest_rate        
    add_index :view_household_loan, :loan_to_value_percent        
    add_index :view_household_loan, :payment_savings_in_cents     
    add_index :view_household_loan, :closing_date                 
    add_index :view_household_loan, :next_arm_rate_adjustment_date
    add_index :view_household_loan, :end_of_intrest_only_period   
    add_index :view_household_loan, :balloon_payment_date         
    add_index :view_household_loan, :loan_type_id                 
    add_index :view_household_loan, :monthly_hh_income_in_cents   
    add_index :view_household_loan, :consumer_debts_in_cents      
    add_index :view_household_loan, :median_credit_score          
    add_index :view_household_loan, :original_loan_amount_in_cents
    add_index :view_household_loan, :age_years                    
    add_index :view_household_loan_search_result, :user_id
  end

  def down
    remove_index :view_household_loan_search_result, :column => :user_id
    remove_index :view_household_loan, :column => :age_years
    remove_index :view_household_loan, :column => :original_loan_amount_in_cents
    remove_index :view_household_loan, :column => :median_credit_score
    remove_index :view_household_loan, :column => :consumer_debts_in_cents
    remove_index :view_household_loan, :column => :monthly_hh_income_in_cents
    remove_index :view_household_loan, :column => :loan_type_id
    remove_index :view_household_loan, :column => :balloon_payment_date
    remove_index :view_household_loan, :column => :end_of_intrest_only_period
    remove_index :view_household_loan, :column => :next_arm_rate_adjustment_date
    remove_index :view_household_loan, :column => :closing_date
    remove_index :view_household_loan, :column => :payment_savings_in_cents
    remove_index :view_household_loan, :column => :loan_to_value_percent
    remove_index :view_household_loan, :column => :current_interest_rate
    remove_index :view_household_loan, :column => :current_loan_amount_in_cents
    remove_index :view_household_loan, :column => :occupancy_type_id
    remove_index :view_household_loan, :column => :property_type_id
    remove_index :view_household_loan, :column => :purchase_price_in_cents
    remove_index :view_household_loan, :column => :property_count
    remove_index :view_household_loan, :column => :available_equity_in_cents
    remove_index :view_household_loan, :column => :zip
    remove_index :view_household_loan, :column => :state
    remove_index :view_household_loan, :column => :city
    remove_index :view_household_loan, :column => :street_name
    remove_index :view_household_loan, :column => :household_name
    remove_index :view_household_loan, :column => :user_id
    remove_index :view_household_loan, :column => :id
  end
end 
