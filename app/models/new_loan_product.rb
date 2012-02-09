class NewLoanProduct < ActiveRecord::Base
  has_many :new_loan_product_rate_margins, :class_name => 'NewLoanProductRateMargin', :foreign_key => :new_loan_product_id
  has_many :refi_loans, :class_name => 'RefiLoan', :foreign_key => :new_loan_product_id
  has_many :new_loan_product_captures, :through => :new_loan_product_rate_margins
  has_many :loans, :through => :refi_loans
  has_many :refi_properties, :through => :refi_loans
  has_many :loan_types, :through => :refi_loans
  
  validates_presence_of :name
  validates_length_of :name, :allow_nil => false, :maximum => 150
  validates_presence_of :lock_days
  validates_numericality_of :lock_days, :allow_nil => false, :only_integer => true
  validates_numericality_of :margin_rate, :allow_nil => true
  validates_numericality_of :index_rate, :allow_nil => true
  validates_numericality_of :initial_cap, :allow_nil => true
  validates_numericality_of :periodic_cap, :allow_nil => true
  validates_numericality_of :lifetime_cap, :allow_nil => true
  validates_presence_of :term
  validates_numericality_of :term, :allow_nil => false, :only_integer => true
  validates_presence_of :fixed_term
  validates_numericality_of :fixed_term, :allow_nil => false, :only_integer => true
  validates_presence_of :is_fixed_rate
  validates_numericality_of :is_fixed_rate, :allow_nil => false, :only_integer => true
  validates_presence_of :is_jumbo
  validates_numericality_of :is_jumbo, :allow_nil => false, :only_integer => true
  validates_presence_of :is_interest_only
  validates_numericality_of :is_interest_only, :allow_nil => false, :only_integer => true

  # TODO - subject to change
  ThirtyYearFixed = 1
  FiveYearARM = 8

end
