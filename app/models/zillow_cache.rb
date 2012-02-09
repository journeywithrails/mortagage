class ZillowCache < ActiveRecord::Base
  validates_length_of :street_address, :allow_nil => true, :maximum => 255
  validates_length_of :city_state_zip, :allow_nil => true, :maximum => 255
  validates_numericality_of :zpid, :allow_nil => true, :only_integer => true
  validates_numericality_of :latitude, :allow_nil => true
  validates_numericality_of :longitude, :allow_nil => true
  validates_numericality_of :zestimate_in_cents, :allow_nil => true, :only_integer => true
  validates_length_of :output_street, :allow_nil => true, :maximum => 255
  validates_length_of :output_zip, :allow_nil => true, :maximum => 10
  validates_length_of :output_city, :allow_nil => true, :maximum => 45
  validates_length_of :output_state, :allow_nil => true, :maximum => 4
  validates_length_of :use_code, :allow_nil => true, :maximum => 45
  validates_length_of :tax_assessment_year, :allow_nil => true, :maximum => 45
  validates_length_of :tax_assessment, :allow_nil => true, :maximum => 45
  validates_length_of :year_built, :allow_nil => true, :maximum => 45
  validates_length_of :lot_size_sq_ft, :allow_nil => true, :maximum => 45
  validates_length_of :bathrooms, :allow_nil => true, :maximum => 45
  validates_length_of :bedrooms, :allow_nil => true, :maximum => 45
  validates_length_of :last_sold_date, :allow_nil => true, :maximum => 45
  validates_length_of :last_sold_price, :allow_nil => true, :maximum => 45
  validates_inclusion_of :failed_to_match, :in => [true, false], :allow_nil => true, :message => ActiveRecord::Errors.default_error_messages[:blank]

end
