class ServerProperty < ActiveRecord::Base
  belongs_to :server, :class_name => 'Server', :foreign_key => :server_id
  
  validates_presence_of :name
  validates_length_of :name, :allow_nil => false, :maximum => 50
  validates_presence_of :property_value
  validates_length_of :property_value, :allow_nil => false, :maximum => 250
  
#  def to_label
#    "#{name}"
#  end
end
