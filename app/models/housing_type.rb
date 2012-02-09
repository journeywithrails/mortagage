class HousingType < ActiveRecord::Base
  has_many :properties
  
  validates_length_of :name, :allow_nil => true, :maximum => 45
end
