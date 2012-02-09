module Admin::HistoricalRateHelper
    
  def interest_rate_column(historical_rate)
    "#{historical_rate.interest_rate}%"
  end
  
  def rate_column(historical_rate)
    "#{historical_rate.rate.name}" unless historical_rate.rate == nil
  end

end