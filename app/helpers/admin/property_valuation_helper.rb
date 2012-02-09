module Admin::PropertyValuationHelper
  
  def value_column(property_valuation)
    number_to_currency(property_valuation.value / 100, :precision => 0)
  end

end