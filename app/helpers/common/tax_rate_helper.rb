module Common::TaxRateHelper
  def top_income_column(tax_rate)
    number_to_currency(tax_rate.top_income, :precision => 2)
  end
  
  def base_tax_column(tax_rate)
    number_to_currency(tax_rate.base_tax, :precision => 2)
  end
  
  def tax_pct_column(tax_rate)
    tax_rate.tax_pct.to_s + "%"
  end 
end
