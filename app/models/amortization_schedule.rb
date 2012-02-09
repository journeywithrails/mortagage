class AmortizationSchedule < ActiveRecord::Base
  belongs_to :loan, :class_name => 'Loan', :foreign_key => :loan_id

  validates_numericality_of :period, :allow_nil => true, :only_integer => true
  validates_numericality_of :rate, :allow_nil => true
  validates_numericality_of :interest, :allow_nil => true, :only_integer => true
  validates_numericality_of :principle, :allow_nil => true, :only_integer => true
  validates_numericality_of :remaining_bal, :allow_nil => true, :only_integer => true
  
  def to_label
    "#{format_cents_as_currency(remaining_bal * 100)}"
  end
end
