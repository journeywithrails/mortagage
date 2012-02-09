class NewLoanProductRateMargin < ActiveRecord::Base
  belongs_to :new_loan_product, :class_name => 'NewLoanProduct', :foreign_key => :new_loan_product_id
  belongs_to :new_loan_product_capture, :class_name => 'NewLoanProductCapture', :foreign_key => :new_loan_product_capture_id
  
  validates_presence_of :rate
  validates_numericality_of :rate, :allow_nil => false
  validates_presence_of :broker_margin
  validates_numericality_of :broker_margin, :allow_nil => false
end
