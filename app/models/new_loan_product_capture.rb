class NewLoanProductCapture < ActiveRecord::Base
  has_many :new_loan_product_fico_ltv_adjustments, :class_name => 'NewLoanProductFicoLtvAdjustment', :foreign_key => :new_loan_product_capture_id
  has_many :new_loan_product_rate_margins, :class_name => 'NewLoanProductRateMargin', :foreign_key => :new_loan_product_capture_id
  has_many :new_loan_products, :through => :new_loan_product_rate_margins
  
  validates_presence_of :date_captured
end
