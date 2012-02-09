require 'test_helper'

class ProposalScenarioTest < ActiveSupport::TestCase
  def test_loan_amount_total
    proposal_scenario = Factory(:proposal_scenario)
    proposal_scenario.loans << Factory(:loan, :loan_amount => 50) 
    proposal_scenario.loans << Factory(:loan, :loan_amount => 75) 
    assert_equal 125, proposal_scenario.loan_amount_total
  end
  
  
 
end
