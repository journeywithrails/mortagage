class PropertyValuation < ActiveRecord::Base
  belongs_to :property #, :class_name => 'Property', :foreign_key => :property_id
  belongs_to :valuation_type, :class_name => 'ValuationType', :foreign_key => :valuation_type_id
  has_many :refi_properties, :class_name => 'RefiProperty', :foreign_key => :property_valuation_id
  
  validates_numericality_of :zpid, :allow_nil => true, :only_integer => true
  validates_numericality_of :value_in_cents, :allow_nil => true, :only_integer => true  

  # ids
  APPRAISAL = 1
  SALE_PRICE = 2
  ZILLOW = 3

  def to_label
    "#{format_cents_as_currency(value_in_cents)}"
  end
end
