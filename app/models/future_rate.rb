class FutureRate < ActiveRecord::Base
  has_many :future_rate_captures, :class_name => 'FutureRateCapture', :foreign_key => :future_rate_id
  has_many :rates, :class_name => 'Rate', :foreign_key => :future_rate_id
  validates_length_of :name, :allow_nil => true, :maximum => 45
end
