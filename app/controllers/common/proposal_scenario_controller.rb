class Common::ProposalScenarioController < ApplicationController

  active_scaffold :proposal_scenario do |config|
    config.columns = [:name, :purchase_price, :down_payment_amount, :down_payment_pct, :closing_scenario, :title_fee_scenario, :created_at]
    config.list.columns = [:name, :purchase_price, :down_payment, :closing_scenario, :title_fee_scenario]
    
    list.sorting = {:name => :desc}
  end
  
  
end
