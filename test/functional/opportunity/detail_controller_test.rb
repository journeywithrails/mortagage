require 'test_helper'

class Opportunity::DetailControllerTest < ActionController::TestCase
  # Replace this with your real tests.
   def setup
     load_user
   end
   
  def test_index_not_logged_in_redirected_to_login
     get :index
     assert_redirected_to new_session_path
  end

  def test_index_logged_in_gets_success
    authorized_user = user(:authorized_user)
    get :index, {}, {:user_id => authorized_user.id}
    assert_response :success
  end
  
end
