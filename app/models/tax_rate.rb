class TaxRate < ActiveRecord::Base
  belongs_to :tax_filing_status, :class_name => 'TaxFilingStatus', :foreign_key => :tax_filing_status_id

  has_many :household_financials, :class_name => 'HouseholdFinancial', :foreign_key => :tax_rate_id
  
#  has_many :households, :through => :household_financials

  validates_numericality_of :top_income_in_cents, :allow_nil => true, :only_integer => true
  validates_presence_of :tax_pct
  validates_numericality_of :tax_pct, :allow_nil => false
  validates_numericality_of :base_tax_in_cents, :allow_nil => true, :only_integer => true
  
  def to_label
    "#{tax_pct}" + "%"
  end
end
