class PropertyForRent < ActiveRecord::Base
  belongs_to :property, :class_name => 'Property', :foreign_key => :property_id
  
  validates_length_of :address1, :allow_nil => true, :maximum => 255
  validates_length_of :address2, :allow_nil => true, :maximum => 255
  validates_length_of :city, :allow_nil => true, :maximum => 45
  validates_length_of :state, :allow_nil => true, :maximum => 5
  validates_length_of :zip, :allow_nil => true, :maximum => 15
  validates_numericality_of :bedrooms, :allow_nil => true, :only_integer => true
  validates_numericality_of :bathrooms, :allow_nil => true, :only_integer => true
  validates_numericality_of :area, :allow_nil => true, :only_integer => true
  validates_numericality_of :price_in_cents, :allow_nil => true, :only_integer => true
  validates_length_of :url, :allow_nil => true, :maximum => 255
end
