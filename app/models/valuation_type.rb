class ValuationType < ActiveRecord::Base
  has_many :property_valuations, :class_name => 'PropertyValuation', :foreign_key => :valuation_type_id
  has_many :properties, :through => :property_valuations
  
  validates_length_of :name, :allow_nil => true, :maximum => 45

  Appraisal = 1
  Sale = 2
  Zillow = 3

end
