module Common::PropertyValuationHelper
  
  def value_column(property_valuation)
    number_to_currency(property_valuation.value, :precision => 0)
  end

end