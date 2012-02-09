require 'test_helper'

class Opportunity::DebtControllerTest < ActionController::TestCase
  # Replace this with your real tests.
   def setup
     load_user
   end
   
  def test_show_not_logged_in_redirected_to_login
    get :show
    assert_redirected_to new_session_path
  end

  def test_show_logged_in_gets_success
    authorized_user = user(:authorized_user)
    get :show, {}, {:user_id => authorized_user.id}
    assert_response :success
  end
  
   def test_debt_consolidation_details_not_logged_in_redirected_to_login
     get :debt_consolidation_details
     assert_redirected_to new_session_path
   end

  def test_debt_consolidation_details_logged_in_gets_success
    authorized_user = user(:authorized_user)
    get :debt_consolidation_details, {}, {:user_id => authorized_user.id,:id => 1}
    assert_response :success
  end
  
  def test_savings_reinvestment_not_logged_in_redirected_to_login
    get :savings_reinvestment
    assert_redirected_to new_session_path
  end

  def test_savings_reinvestment_logged_in_gets_success
    authorized_user = user(:authorized_user)
    get :savings_reinvestment, {}, {:user_id => authorized_user.id,:id => 1}
    assert_response :success
  end
  
  def test_debt_property_information_not_logged_in_redirected_to_login
     get :debt_property_information
     assert_redirected_to new_session_path
  end

  def test_debt_property_information_logged_in_gets_success
    authorized_user = user(:authorized_user)
    get :debt_property_information, {}, {:user_id => authorized_user.id,:id => 1}
    assert_response :success
  end
  
end
