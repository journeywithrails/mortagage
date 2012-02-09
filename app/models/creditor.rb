class Creditor < ActiveRecord::Base
  belongs_to :loan, :class_name => 'Loan', :foreign_key => :loan_id
  validates_length_of :name, :allow_nil => true, :maximum => 45
  validates_length_of :creditor_type, :allow_nil => true, :maximum => 5
  validates_inclusion_of :to_be_paid_off, :in => [true, false], :allow_nil => true, :message => ActiveRecord::Errors.default_error_messages[:blank]
  validates_numericality_of :unpaid_balance_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :monthly_payment_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :months_left, :allow_nil => true, :only_integer => true
end
