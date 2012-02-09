class ProposalScenarioLoan < ActiveRecord::Base
  belongs_to :loan, :class_name => 'Loan', :foreign_key => :loan_id
  belongs_to :proposal_scenario, :class_name => 'ProposalScenario', :foreign_key => :proposal_scenario_id
end
