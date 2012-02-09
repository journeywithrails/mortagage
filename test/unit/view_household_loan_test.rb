require 'test_helper'

class ViewHouseholdLoanTest < ActiveSupport::TestCase
  fixtures :view_household_loan

  def test_fixture
    v = view_household_loan(:default)
    assert_equal v.city, "North Pole"
  end
  
end
