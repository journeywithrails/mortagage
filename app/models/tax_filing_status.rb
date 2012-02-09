class TaxFilingStatus < ActiveRecord::Base
  has_many :tax_rate, :class_name => 'TaxRate', :foreign_key => :tax_filing_status_id
  
  validates_presence_of :name
  validates_length_of :name, :allow_nil => false, :maximum => 60
end
