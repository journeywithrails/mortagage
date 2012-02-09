require 'test_helper'
class SessionsControllerTest < ActionController::TestCase
  def setup
    load_user
  end
  
  def test_new
    get :new
    assert_response :success
  end

  def test_create
    post :create, {:email => user(:authorized_user).email, :password => 'password'}
    assert_redirected_to root_url
  end
end
