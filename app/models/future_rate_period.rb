class FutureRatePeriod < ActiveRecord::Base
  belongs_to :future_rate_capture, :class_name => 'FutureRateCapture', :foreign_key => :future_rate_capture_id
  validates_numericality_of :interest_rate, :allow_nil => true
end
