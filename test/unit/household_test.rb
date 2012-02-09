require 'test_helper'

class HouseholdTest < ActiveSupport::TestCase
  fixtures :household, :person, :loan

  def test_related_loans
    default_hh = household(:default)

    assert_equal 2, Loan.all(:conditions => "co_borrower_person_id = #{person(:default).id}").length, \
      "There should be two loans where default person is the co_borrower. \
      One record belongs to authorized_user, and one to competing_broker"
      
    assert_equal 1, default_hh.related_loans.length, \
      "Only one of the loans belongs to authorized_user, so this should return one record"
  end
end
