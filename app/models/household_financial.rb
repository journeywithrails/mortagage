class HouseholdFinancial < ActiveRecord::Base
  belongs_to :household, :class_name => 'Household', :foreign_key => :household_id
  belongs_to :tax_rate, :class_name => 'TaxRate', :foreign_key => :tax_rate_id
  
  validates_numericality_of :estimated_income_in_cents, :allow_nil => true, :only_integer => true
  
  def to_label
    "#{format_cents_as_currency(estimated_income_in_cents)}"
  end
  
end
