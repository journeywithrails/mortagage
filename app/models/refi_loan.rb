class RefiLoan < ActiveRecord::Base
  belongs_to :loan, :class_name => 'Loan', :foreign_key => :loan_id
  belongs_to :loan_type, :class_name => 'LoanType', :foreign_key => :loan_type_id
  belongs_to :new_loan_product, :class_name => 'NewLoanProduct', :foreign_key => :new_loan_product_id
  belongs_to :refi_property, :class_name => 'RefiProperty', :foreign_key => :refi_property_id

  validates_numericality_of :loan_rank, :allow_nil => true, :only_integer => true
  validates_numericality_of :loan_amount_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :note_rate, :allow_nil => true
  validates_numericality_of :monthly_payment_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :next_year_interest_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :loan_term, :allow_nil => true, :only_integer => true
  validates_numericality_of :rate_minus_1pt_monthly_payment_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :rate_plus_2pt_monthly_payment_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :rate_plus_4pt_monthly_payment_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :total_interest_paid_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :total_principal_paid_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :total_interest_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :total_principal_in_cents, :allow_nil => true, :only_integer => true

  def note_rate_label
    "#{note_rate}%" if note_rate
  end

  def loan_term_label
    "#{loan_term} #{period_label}" if loan_term
  end

  def period_label
    if loan then
      if loan.biweekly_payments then
        return "two week periods"
      end
    end
   "months"
  end

  def loan_rank_label
    loan.loan_rank > 1 ? " (2nd)" : ""
  end
  
end
