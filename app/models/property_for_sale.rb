class PropertyForSale < ActiveRecord::Base
  belongs_to :property, :class_name => 'Property', :foreign_key => :property_id

  def property_address
    "#{address1}, #{city}, #{state}, #{zip}"
  end

end
