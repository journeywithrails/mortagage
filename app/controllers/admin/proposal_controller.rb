class Admin::ProposalController < AdminController
  active_scaffold :proposal do |config|
    config.columns = [:name, :household, :property, :proposal_scenarios, :created_at, :updated_at]
    config.columns[:property].includes = nil
    config.columns[:household].includes = nil
    list.sorting = {:name => :desc}
    config.actions.exclude  :show, :delete, :update
  end
end
