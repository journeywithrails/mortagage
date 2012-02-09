class RefiProperty < ActiveRecord::Base
  belongs_to :property, :class_name => 'Property', :foreign_key => :property_id
  belongs_to :property_valuation, :class_name => 'PropertyValuation', :foreign_key => :property_valuation_id
  belongs_to :refi_scenario, :class_name => 'RefiScenario', :foreign_key => :refi_scenario_id
  
  has_many :refi_loans, :class_name => 'RefiLoan', :foreign_key => :refi_property_id, :order => "loan_rank"
  has_many :loan_types, :through => :refi_loans
  
  validates_inclusion_of :is_primary_residence, :in => [true, false], :allow_nil => true, :message => ActiveRecord::Errors.default_error_messages[:blank]
  validates_inclusion_of :is_pmi_deductible, :in => [true, false], :allow_nil => true, :message => ActiveRecord::Errors.default_error_messages[:blank]
  validates_numericality_of :monthly_pmi_in_cents, :allow_nil => true, :only_integer => true
  validates_inclusion_of :keep_original_loans, :in => [true, false], :allow_nil => true, :message => ActiveRecord::Errors.default_error_messages[:blank]


  def total_loan_amount_in_cents
    total = 0  
    refi_loans.each do |loan|
      total += loan.loan_amount_in_cents
    end  
    total
  end

  def current_valuation_in_cents
    property_valuation.value_in_cents
  end

  def combined_loan_rates
    combined_string = ""
    refi_loans.each do |loan|
      combined_string += "/" if combined_string != "" # append a separator if we've got more than one rate
      combined_string += loan.note_rate.to_s + "%"
    end  
    combined_string
  end

  def refi_loan_for_new_loan_product(new_loan_product_id)
    refi_loans.find_by_new_loan_product_id(new_loan_product_id)
  end
  
end
