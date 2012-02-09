require 'test_helper'

class Portfolio::DemographicsControllerTest < ActionController::TestCase
   def setup
     load_user
   end
   
   def test_show_not_logged_in_user_gets_401
    xml_http_request :get, :show
    assert_response :unauthorized
  end

  def test_show_logged_in_gets_success
    authorized_user = user(:authorized_user)
    xml_http_request :get, :show, {}, {:user_id => authorized_user.id}
    assert_response :success
  end
end
