class HistoricalRate < ActiveRecord::Base
  belongs_to :rate, :class_name => 'Rate', :foreign_key => :rate_id
  validates_numericality_of :interest_rate, :allow_nil => true
  
  def to_label
    "#{interest_rate}%"
  end  
end
