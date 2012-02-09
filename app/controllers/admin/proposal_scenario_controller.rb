class Admin::ProposalScenarioController < AdminController
  active_scaffold :proposal_scenario do |config|
    config.columns = [:name, :purchase_price, :down_payment_amount, :down_payment_pct, :loans, :closing_scenario, :title_fee_scenario, :created_at]
    config.columns[:loans].includes = nil
    list.sorting = {:name => :desc}
  end  
end
