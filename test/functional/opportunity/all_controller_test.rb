require 'test_helper'

class Opportunity::AllControllerTest < ActionController::TestCase
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
  
  def test_show_with_factory_girl
    authorized_user = user(:authorized_user)  
    100.times do     
    household = Factory(:household, :user_id =>authorized_user.id, :account_id => account(:default).id)
    Factory(:household_event, :account_id => account(:default).id,:date => Time.now,:household_id => household.id  )
    end
    Factory(:person)
    get :show, {}, {:user_id => authorized_user.id}
    assert assigns(:households_for_news_search)
    assert_equal 5, assigns(:households_for_news_search).size
    assert_not_nil assigns(:properties_for_sale)
    assert_not_nil assigns(:household_events)
    assert_equal 20, assigns(:household_events).size
    assert_not_nil assigns(:recent_activities)
 end  
  

end
