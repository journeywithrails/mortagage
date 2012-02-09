require 'test_helper'

class Opportunity::RateriskControllerTest < ActionController::TestCase
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
  
  def test_list_not_logged_in_user_gets_401
    xml_http_request :get, :list
    assert_response :unauthorized
  end
  
  def test_list_logged_in_gets_success
    authorized_user = user(:authorized_user)    
    xml_http_request :get, :list,{}, {:user_id => authorized_user.id}
    assert_response :success
  end
  
  
  def test_rate_risk_opportunity_not_logged_in_redirected_to_login
    get :rate_risk_opportunity
    assert_redirected_to new_session_path
  end

  def test_rate_risk_opportunity_logged_in_gets_success
    authorized_user = user(:authorized_user)
    get :rate_risk_opportunity, {}, {:user_id => authorized_user.id,:id => 1}
    assert_response :success
  end
  
  def test_hh_summary_not_logged_in_redirected_to_login
    get :hh_summary
    assert_redirected_to new_session_path
  end

  def test_hh_summary_logged_in_gets_success
    authorized_user = user(:authorized_user)
    get :hh_summary, {}, {:user_id => authorized_user.id,:id => 1}
    assert_response :success
  end 
  
end
