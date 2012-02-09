class NewLoanProductFicoLtvAdjustment < ActiveRecord::Base
  belongs_to :new_loan_product_capture, :class_name => 'NewLoanProductCapture', :foreign_key => :new_loan_product_capture_id
  
  validates_inclusion_of :loan_term_gt_15_yrs, :in => [true, false], :allow_nil => false, :message => ActiveRecord::Errors.default_error_messages[:blank]
  validates_inclusion_of :cash_out_refi, :in => [true, false], :allow_nil => false, :message => ActiveRecord::Errors.default_error_messages[:blank]
  validates_inclusion_of :expanded_approval, :in => [true, false], :allow_nil => false, :message => ActiveRecord::Errors.default_error_messages[:blank]
  validates_presence_of :min_ltv
  validates_numericality_of :min_ltv, :allow_nil => false
  validates_presence_of :max_ltv
  validates_numericality_of :max_ltv, :allow_nil => false
  validates_presence_of :min_fico
  validates_numericality_of :min_fico, :allow_nil => false, :only_integer => true
  validates_presence_of :max_fico
  validates_numericality_of :max_fico, :allow_nil => false, :only_integer => true
  validates_numericality_of :adjustor, :allow_nil => true
end
