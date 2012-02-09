require 'test_helper'

class Opportunity::RefinanceControllerTest < ActionController::TestCase
  fixtures :household, :person, :property
  
  def setup
     load_user  
    @basic_search_conditions = {:search => {:conditions => {:head_of_hh_person => {:first_name_keywords => ''}}}}
  end  

  def test_show_not_logged_in_redirected_to_login
    get :show
    assert_redirected_to new_session_path
  end

  def test_show_logged_in_user_gets_success
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
    xml_http_request :get, :list, @basic_search_conditions, {:user_id => authorized_user.id}
    assert_response :success
  end
  
  
    def test_search_not_logged_in_user_gets_401
    xml_http_request :get, :search
    assert_response :unauthorized
  end

  def test_search_logged_in_gets_success
    authorized_user = user(:authorized_user)    
    xml_http_request :get, :search, @basic_search_conditions, {:user_id => authorized_user.id}
    assert_response :success
  end
  
  
  
  def test_search_finds_head_of_hh_person_first_name
    authorized_user = user(:authorized_user)    
    conditions = {:search => {:conditions => {:head_of_hh_person => {:first_name_keywords => "Chue"}}}}
    xml_http_request :get, :search, conditions, {:user_id => authorized_user.id}
    assert_response :success
  end
  
  def test_search_finds_head_of_hh_person_last_name
    authorized_user = user(:authorized_user)    
    conditions = {:search => {:conditions => {:head_of_hh_person => {:first_name_keywords => "Carillo"}}}}
    xml_http_request :get, :search, conditions, {:user_id => authorized_user.id}
    assert_response :success
  end
  
  def test_search_finds_head_of_hh_person_address1
    authorized_user = user(:authorized_user)    
    conditions = {:search => {:conditions => {:head_of_hh_person => {:first_name_keywords => "Boulder"}}}}
    xml_http_request :get, :search, conditions, {:user_id => authorized_user.id}
    assert_response :success
  end
  
  def test_search_finds_head_of_hh_person_city
    authorized_user = user(:authorized_user)    
    conditions = {:search => {:conditions => {:head_of_hh_person => {:first_name_keywords => "North"}}}}
    xml_http_request :get, :search, conditions, {:user_id => authorized_user.id}
    assert_response :success
  end
  

  def test_property_information_not_logged_in_redirected_to_login
    get :property_information
    assert_redirected_to new_session_path
  end
  
    def test_property_information_logged_in_gets_success
    authorized_user = user(:authorized_user)    
    get :property_information, {:id =>  household(:default) }, {:user_id => authorized_user.id}
    assert_response :success
    assert_tag :content => /3500 arapahoe ave/
    assert_tag :content => /Boulder/    
   end
  
  def test_property_information2_not_logged_in_redirected_to_login
   get :property_information2
   assert_redirected_to new_session_path   
 end
 
   def test_property_information2_logged_in_gets_success
   authorized_user = user(:authorized_user)   
   get :property_information2, {}, {:user_id => authorized_user.id}
   assert_response :success  
 end
 
   def test_property_information3_not_logged_in_redirected_to_login
   get :property_information3
   assert_redirected_to new_session_path   
 end
 
   def test_property_information3_logged_in_gets_success
   authorized_user = user(:authorized_user)   
   get :property_information3, {}, {:user_id => authorized_user.id}
   assert_response :success  
  end
  
  

end
