class OpportunityType < ActiveRecord::Base
  # has_many :households_as_best_opportunity_type, :class_name => 'Household', :foreign_key => :best_opportunity_type_id
  has_many :household_reports, :class_name => 'HouseholdReport', :foreign_key => :opportunity_type_id

  validates_length_of :name, :allow_nil => true, :maximum => 45
  
  # type ids
  Refinance = 1
  DebtConsolidation = 2
  CollegePlanning = 3
  Retirement = 4
  ARMWatch = 5
  
end
