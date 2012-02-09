class FutureRateCapture < ActiveRecord::Base
  belongs_to :future_rate, :class_name => 'FutureRate', :foreign_key => :future_rate_id
  has_many :future_rate_periods, :class_name => 'FutureRatePeriod', :foreign_key => :future_rate_capture_id
end
