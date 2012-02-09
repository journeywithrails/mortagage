class LoanStatus < ActiveRecord::Base
  has_many :loan, :class_name => 'Loan', :foreign_key => :loan_status_id
  
  validates_length_of :status_name, :allow_nil => true, :maximum => 45
  
  Closed = 1
  Open = 2
  Abandoned = 3
  Proposed = 4
  
  def to_label
    "#{status_name}"
  end
end
