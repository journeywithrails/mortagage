class RenameColumnsViewHouseholdLoan < ActiveRecord::Migration
  def self.up
    rename_column(:view_household_loan, :property_type_id, :housing_type_id)
    rename_column(:view_household_loan, :occupancy_type_id, :property_use_id)
  end

  def self.down
    rename_column(:view_household_loan, :housing_type_id, :property_type_id)
    rename_column(:view_household_loan, :property_use_id, :occupancy_type_id)
  end
end
