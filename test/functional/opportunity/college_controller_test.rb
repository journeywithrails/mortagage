require 'test_helper'

class Opportunity::CollegeControllerTest < ActionController::TestCase
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
  
  def test_college_planning_requirements_not_logged_in_redirected_to_login
    get :college_planning_requirements
    assert_redirected_to new_session_path
  end  
  
  def test_college_planning_requirements_logged_in_gets_success
    authorized_user = user(:authorized_user)
    get :college_planning_requirements, {}, {:user_id => authorized_user.id, :id => 1}
    assert_response :success
  end  
  
  
  
  def test_loan_option2_not_logged_in_redirected_to_login
    get :loan_option2
    assert_redirected_to new_session_path
  end  
    
  def test_loan_option2_logged_in_gets_success
    authorized_user = user(:authorized_user)
    get :loan_option2, {}, {:user_id => authorized_user.id, :id => 1}
    assert_response :success
  end 




  def test_loan_comparison_not_logged_in_redirected_to_login
    get :loan_comparison
    assert_redirected_to new_session_path 
  end  
  
  def test_loan_comparison_logged_in_gets_success
    authorized_user = user(:authorized_user)
    get :loan_comparison, {}, {:user_id => authorized_user.id, :id => 1}
    assert_response :success
  end  
  
  
  
  
  def test_hh_summary_not_logged_in_redirected_to_login
    get :hh_summary
    assert_redirected_to new_session_path 
  end  
  
  def test_hh_summary_logged_in_gets_success
    authorized_user = user(:authorized_user)
    get :hh_summary, {}, {:user_id => authorized_user.id, :id => 1}
    assert_response :success
  end    
  
end
