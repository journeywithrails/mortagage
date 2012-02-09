require 'test_helper'

class BrokerServerTest < ActiveSupport::TestCase
  def setup
    Fixtures.create_fixtures(File.dirname(__FILE__) + "/../fixtures", "broker_server"){AccountModel.connection}
  end

  def test_truth
    assert true
  end
end
