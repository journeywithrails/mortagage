require 'test_helper'

class BrokerUserTest < ActiveSupport::TestCase
  fixtures :proposal, :proposal_scenario
  def setup
    load_user
  end
  
  def test_proposal_scenarios_only_loads_owned_scenarios
    assert_equal 3, broker_user(:authorized_user).proposal_scenarios.count 
  end
end
