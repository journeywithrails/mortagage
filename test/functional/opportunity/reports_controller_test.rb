require 'test_helper'

class Opportunity::ReportsControllerTest < ActionController::TestCase
  fixtures  :household
  def setup
    load_user
  end

  def test_show_not_logged_in_redirected_to_login
    post :refinance
    assert_redirected_to new_session_path
  end
  
end
