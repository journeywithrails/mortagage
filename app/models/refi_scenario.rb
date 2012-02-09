class RefiScenario < ActiveRecord::Base
  belongs_to :household, :class_name => 'Household', :foreign_key => :household_id
  
  has_many :refi_properties, :class_name => 'RefiProperty', :foreign_key => :refi_scenario_id
  has_many :property_valuations, :through => :refi_properties
  has_many :properties, :through => :refi_properties
  has_many :household_reports, :class_name => 'HouseholdReport', :foreign_key => :refi_scenario_id
  
  validates_inclusion_of :is_base_case, :in => [true, false], :allow_nil => true, :message => ActiveRecord::Errors.default_error_messages[:blank]
  validates_numericality_of :total_loan_value_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :total_monthly_payment_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :total_equity_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :total_tax_deduction_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :total_present_value_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :net_monthly_payment_change_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :total_cash_out_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :net_change_in_tax_deduction_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :net_change_in_present_value_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :pv_of_new_loans_at_old_wacc_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :refi_score, :allow_nil => true
  validates_numericality_of :college_score, :allow_nil => true
  validates_numericality_of :retirement_score, :allow_nil => true
  validates_numericality_of :reduce_risk_score, :allow_nil => true
  validates_numericality_of :consolidate_debt_score, :allow_nil => true

  # description of the best scored scenario type
  def best_type
    # TODO - check different scores & return a description of the best score:
    # Refinance, College Planning, Debt Consolidation, Retirement, Risk Reduction
    "Refinance" 
  end

  def refi_property_for_property_id(property_id)
    refi_properties.find_by_property_id(property_id)
  end

  def original_loan_changed_for_property(property_id)
    refi_property = refi_property_for_property_id(property_id)

    if refi_property then
      !refi_property.keep_original_loans
    else
      false
    end
  end
 
end
