class ProcessTypeProperty < ActiveRecord::Base
  belongs_to :process_type, :class_name => 'ProcessType', :foreign_key => :process_type_id
  validates_presence_of :name
  validates_length_of :name, :allow_nil => false, :maximum => 50
  validates_presence_of :property_value
  validates_length_of :property_value, :allow_nil => false, :maximum => 250
end
