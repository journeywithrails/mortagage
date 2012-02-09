class LoanFlag < ActiveRecord::Base
  belongs_to :loan, :class_name => 'Loan', :foreign_key => :loan_id
  validates_length_of :message, :allow_nil => true, :maximum => 255
  validates_numericality_of :severity, :allow_nil => true, :only_integer => true
end
