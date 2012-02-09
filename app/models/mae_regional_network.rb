class MaeRegionalNetwork < ActiveRecord::Base
  has_many :loans, :class_name => 'Loan', :foreign_key => :mae_regional_network_id
  has_many :users, :class_name => 'User', :foreign_key => :mae_regional_network_id

  validates_length_of :name, :allow_nil => true, :maximum => 100
end
