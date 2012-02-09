require 'test_helper'

class Opportunity::RetireControllerTest < ActionController::TestCase
   fixtures :household
   
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
  
    def test_retirement_information_not_logged_in_redirected_to_login
    get :retirement_information
    assert_redirected_to new_session_path
  end  
    
  def test_retirement_information_logged_in_gets_success
    authorized_user = user(:authorized_user)
    get :retirement_information, {}, {:user_id => authorized_user.id}
    assert_response :success
    # checking with the static page content of retirement_information 'Anne Wilkins'
    assert_tag :content => /Anne Wilkins /
  end  
  
  def test_loan_option2_not_logged_in_redirected_to_login
    get :loan_option2
    assert_redirected_to new_session_path
  end  
    
  def test_loan_option2_logged_in_gets_success
    authorized_user = user(:authorized_user)
    get :loan_option2, {}, {:user_id => authorized_user.id}
    assert_response :success
    # checking with the static page content of retirement_information page 'Anne Wilkins'
    assert_tag :content => /Anne Wilkins /
  end
  
  def test_loan_comparison_not_logged_in_redirected_to_login
    get :loan_comparison
    assert_redirected_to new_session_path
  end  
    
  def test_loan_comparison_logged_in_gets_success
    authorized_user = user(:authorized_user)
    get :loan_comparison, {}, {:user_id => authorized_user.id}
    assert_response :success
    # checking with the static page content of loan_comparison page 'Anne Wilkins'
    assert_tag :content => /Anne Wilkins /
  end
  
    def test_hh_summary_not_logged_in_redirected_to_login
    get :hh_summary
    assert_redirected_to new_session_path
  end  
    
  def test_hh_summary_logged_in_gets_success
    authorized_user = user(:authorized_user)
    get :hh_summary, {}, {:user_id => authorized_user.id}
    assert_response :success
    # checking with the static page content of hh_summary page 'Anne Wilkins'
    assert_tag :content => /Anne Wilkins /
  end
  
end
