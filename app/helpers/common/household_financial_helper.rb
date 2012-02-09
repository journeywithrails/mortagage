module Common::HouseholdFinancialHelper
  def estimated_income_column(household_financial)
    number_to_currency(household_financial.estimated_income, :precision => 0)
  end
  
end