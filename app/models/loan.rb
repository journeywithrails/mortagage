require 'tim_foo'

class Loan < ActiveRecord::Base
  include TimFoo

  belongs_to :property, :class_name => 'Property', :foreign_key => :property_id
  belongs_to :property_use, :class_name => 'PropertyUse', :foreign_key => :property_use_id
  belongs_to :loan_type, :class_name => 'LoanType', :foreign_key => :loan_type_id
  belongs_to :borrower_person, :class_name => 'Person', :foreign_key => :borrower_person_id
  belongs_to :co_borrower_person, :class_name => 'Person', :foreign_key => :co_borrower_person_id
  belongs_to :rate, :class_name => 'Rate', :foreign_key => :rate_id
  belongs_to :loan_status, :class_name => 'LoanStatus', :foreign_key => :loan_status_id
  belongs_to :user, :class_name => 'BrokerUser', :foreign_key => :user_id
  belongs_to :mae_regional_network
  belongs_to :new_loan_product

  has_many :amortization_schedule, :class_name => 'AmortizationSchedule', :foreign_key => :loan_id
  has_many :loan_flags, :class_name => 'LoanFlag', :foreign_key => :loan_id
  has_many :proposal_scenario_loans, :class_name => 'ProposalScenarioLoan', :foreign_key => :loan_id
  has_many :proposal_scenarios, :through => :proposal_scenario_loans
  has_many :refi_loans, :class_name => 'RefiLoan', :foreign_key => :loan_id
  
  validates_numericality_of :loan_rank, :allow_nil => true, :only_integer => true
  validates_inclusion_of :is_active, :in => [true, false], :allow_nil => true, :message => ActiveRecord::Errors.default_error_messages[:blank]
  validates_length_of :loan_guid, :allow_nil => true, :maximum => 255
  validates_numericality_of :loan_amount_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :final_balloon_payment_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :loan_term_periods, :allow_nil => true, :only_integer => true
  validates_numericality_of :loan_due_in_periods, :allow_nil => true, :only_integer => true
  validates_numericality_of :interest_only_periods, :allow_nil => true, :only_integer => true
  validates_numericality_of :fixed_payment_periods, :allow_nil => true, :only_integer => true
  validates_length_of :loan_type_details, :allow_nil => true, :maximum => 255
  validates_numericality_of :note_rate, :allow_nil => true
  validates_numericality_of :index_rate, :allow_nil => true
  validates_numericality_of :margin_rate, :allow_nil => true
  validates_length_of :index_code, :allow_nil => true, :maximum => 45
  validates_numericality_of :first_adjustment_period, :allow_nil => true, :only_integer => true
  validates_numericality_of :subsequent_adjustment_period, :allow_nil => true, :only_integer => true
  validates_numericality_of :first_adjustment_rate_cap, :allow_nil => true
  validates_numericality_of :periodic_adjustment_rate_cap, :allow_nil => true
  validates_numericality_of :lifetime_interest_rate_cap, :allow_nil => true
  validates_numericality_of :lifetime_interest_rate_floor, :allow_nil => true
  validates_numericality_of :first_adjustment_cap, :allow_nil => true
  validates_numericality_of :max_loan_to_value_percent, :allow_nil => true, :only_integer => true
  validates_inclusion_of :biweekly_payments, :in => [true, false], :allow_nil => true, :message => ActiveRecord::Errors.default_error_messages[:blank]
  validates_numericality_of :payment_adjustment_period, :allow_nil => true, :only_integer => true
  validates_numericality_of :payment_adjustment_cap, :allow_nil => true
  validates_numericality_of :loan_recast_period, :allow_nil => true, :only_integer => true
  validates_inclusion_of :has_pmi, :in => [true, false], :allow_nil => true, :message => ActiveRecord::Errors.default_error_messages[:blank]
  validates_numericality_of :pmi_expires_ltv, :allow_nil => true
  validates_numericality_of :disc_rate_1, :allow_nil => true
  validates_numericality_of :disc_period_1, :allow_nil => true, :only_integer => true
  validates_numericality_of :disc_rate_2, :allow_nil => true
  validates_numericality_of :disc_period_2, :allow_nil => true, :only_integer => true
  validates_numericality_of :disc_rate_3, :allow_nil => true
  validates_numericality_of :disc_period_3, :allow_nil => true, :only_integer => true
  validates_numericality_of :disc_rate_4, :allow_nil => true
  validates_numericality_of :disc_period_4, :allow_nil => true, :only_integer => true
  validates_numericality_of :disc_rate_5, :allow_nil => true
  validates_numericality_of :disc_period_5, :allow_nil => true, :only_integer => true
  validates_numericality_of :rounding_increment, :allow_nil => true
  validates_inclusion_of :round_rates_up, :in => [true, false], :allow_nil => true, :message => ActiveRecord::Errors.default_error_messages[:blank]
  validates_numericality_of :commission_in_cents, :allow_nil => true, :only_integer => true
  
  class << self
    def fixed_rate_type
      2
    end
    
    def arm_type
      4
    end
  end

  def to_label
    "#{format_cents_as_currency(loan_amount_in_cents)}"
  end
  
  def note_rate_percent
    self.note_rate.to_f * 100
  end

  def note_rate_percent=(value)
    self.note_rate = value.to_f / 100
  end
  
  def principal_value
    @principal_value ||= loan_amount_in_cents.to_d / 100
  end
  
  def monthly_payment
    #TODO only works for fixed rate loans right now
     @monthly_payment ||= -payment(periodic_interest_rate, loan_term_periods, principal_value, 0)
  end
  
  def periodic_interest_rate 
    @periodic_interest_rate ||= note_rate.to_d / 12
  end
  
  def apr
    interest_rate(loan_term_periods, -monthly_payment, principal_value, 0)
  end

  def remaining_balance
  	11111
	end
end
