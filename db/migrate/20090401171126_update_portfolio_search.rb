class UpdatePortfolioSearch < ActiveRecord::Migration
  def self.up
    rename_column :view_household_loan, :household_name, :borrower_name
    add_column :view_household_loan, :co_borrower_name, :string

    remove_column :view_household_loan_search_result, :household_name
    add_column :view_household_loan_search_result, :names, :text
    add_column :view_household_loan_search_result, :addresses, :text
  end

  def self.down
    rename_column :view_household_loan, :borrower_name, :household_name
    remove_column :view_household_loan, :co_borrower_name

    add_column :view_household_loan_search_result, :household_name
    remove_column :view_household_loan_search_result, :names
    remove_column :view_household_loan_search_result, :addresses
  end
end
