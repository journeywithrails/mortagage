require 'test_helper'

class Portfolio::HouseholdOverviewControllerTest < ActionController::TestCase
  fixtures :loan_type, :loan, :refi_loan, :property_valuation, :property, :refi_scenario, :refi_property, :person, :household, :person_financial
  def setup
    load_user
  end

  def test_index
    get :index, {}, {:user_id => broker_user(:authorized_user).id}
    assert_redirected_to :controller => 'portfolio/demographics'
  end

  def test_show
    get :show, {:id => household(:default).id}, {:user_id => broker_user(:authorized_user).id}
    assert_response :success
    assert_select "span[id^=loan_history_label_#{property(:mofo).id}]" 
    assert_tag /Eastwood/ #Eastwood is on a related loan
    assert_tag /Deadwood/ #Deadwood is on a related loan
  end

  def test_show_eastwood_household
    get :show, {:id => household(:eastwood_household).id}, {:user_id => broker_user(:authorized_user).id}
    assert_response :success
    assert_tag /No related loans/ #Eastwood is not coborrower on any loans
  end
end
