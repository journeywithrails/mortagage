module Common::ProposalScenarioHelper
  
  def purchase_price_column(scenario)
    number_to_currency(scenario.purchase_price, :precision => 0)
  end
  
  def down_payment_column(scenario)
    return number_to_currency(scenario.down_payment_amount.to_f) unless scenario.down_payment_amount == nil
    "#{scenario.down_payment_pct}%" unless scenario.down_payment_pct == nil
  end

end