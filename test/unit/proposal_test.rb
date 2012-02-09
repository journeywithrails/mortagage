require 'test_helper'

class ProposalTest < ActiveSupport::TestCase
  fixtures :proposal

  def test_sort_activity_date
    proposals = Proposal.find(:all, :order => "updated_at")

    activities = []
    activities += proposals

    # default is older

    assert_same(proposal(:default).updated_at.day, activities.first.activity_date.day)

    activities.sort_by {|a| a.activity_date}
    activities.reverse!

    # note: does not work:
    # activities.sort_by(&:activity_date).reverse!

    assert_same(proposal(:belongs_to_other_broker).updated_at.day, activities.first.activity_date.day)

  end
end
