require 'test_helper'

class Portfolio::ViewHouseholdLoanControllerTest < ActionController::TestCase
  fixtures :view_household_loan_search_result, :view_household_loan

  def setup
    load_user
    @basic_conditions = {:search => {:conditions => {:group => {:names_keywords => ''}}}}
    @advanced_conditions = {:search=>{:conditions=>{:group => {:names_keywords=>"reno"}}}, \
        :household => {:interest_gte => 1, :interest_lte => 2, :balloon_gte => 1, :balloon_lte => 2}}
  end

  def test_index_not_logged_in_redirected_to_login
    get :index
    assert_redirected_to new_session_path
  end

  def test_index_logged_in_user_gets_success
    authorized_user = user(:authorized_user)

    # by setting the user_id in the session the controller thinks the user
    # is logged in.
    get :index, {}, {:user_id => authorized_user.id}

    assert_response :success
  end
  
  def test_search_not_logged_in_user_gets_401
    xml_http_request :get, :do_search
    assert_response :unauthorized
  end

  def test_search_logged_in_gets_success
    authorized_user = user(:authorized_user)
    
    # by setting the user_id in the session the controller thinks the user
    # is logged in.
    xml_http_request :get, :do_search, @basic_conditions, {:user_id => authorized_user.id}

    assert_response :success
  end

  def test_search_finds_clint_eastwood
    authorized_user = user(:authorized_user)
    
    conditions = {:search => {:conditions => {:group => {:names_keywords => "ClInT"}}}}
    xml_http_request :get, :do_search, conditions, {:user_id => authorized_user.id}

    assert_response :success
    assert_tag :content => /Clint Eastwood/
    assert_no_tag :content => /Joe Smith/
  end

  def test_search_finds_north_pole
    authorized_user = user(:authorized_user)
    
    conditions = {:search => {:conditions => {:group => {:names_keywords => "NoRtH"}}}}
    xml_http_request :get, :do_search, conditions, {:user_id => authorized_user.id}

    assert_response :success
    assert_tag :content => /North Pole/
    assert_no_tag :content => /Boulder/
  end

  def test_advanced_search_finds_north_pole_by_street_name
     authorized_user = user(:authorized_user)
    
    conditions = {:search => {:conditions => {:street_name_keywords => "NoRtH", :city_keywords => ""}}}
    xml_http_request :get, :do_advanced_search, conditions, {:user_id => authorized_user.id}

    assert_response :success
    assert_tag :content => /North Pole/
    assert_no_tag :content => /Boulder/
  end

  def test_advanced_search_finds_north_pole_by_city
    authorized_user = user(:authorized_user)

    conditions = {:search => {:conditions => {:city_keywords => "NoRtH", :street_name_keywords => ""}}}
    xml_http_request :get, :do_advanced_search, conditions, {:user_id => authorized_user.id}

    assert_response :success
    assert_tag :content => /North Pole/
    assert_no_tag :content => /Boulder/
  end

  def test_search_logged_in_search
    authorized_user = user(:authorized_user)
    
    # by setting the user_id in the session the controller thinks the user
    # is logged in.
    @result = ViewHouseholdLoan.new_search()
   
    @result.conditions.borrower_name_keywords = "reno"
    @result.conditions.co_borrower_name_keywords = "reno"
    @result.conditions.or_street_name_keywords = "reno"
    @result.conditions.or_city_keywords = "reno"
    @result.conditions.user_id = 1
    @result.group = "id"  
    @result.page = 1  
    @result.per_page = @result.count
    @final=@result.all
    @result = "#{@final.map{|s| s.id}.join(',')}" 
    
    @searchresult = ViewHouseholdLoanSearchResult.find(:all, :conditions => "id IN (#{@result.size != 0 ? @result : 0})")
    
    xml_http_request :get, :do_search, @advanced_conditions, {:user_id => authorized_user.id}  
    assert_response :success 
    
  end

  def test_advanced_search_not_logged_in_user_gets_401
    xml_http_request :get, :advanced_search
    assert_response :unauthorized 
  end

  def test_advanced_search_logged_in_user_gets_success
    authorized_user = user(:authorized_user)
    
    # by setting the user_id in the session the controller thinks the user
    # is logged in.
    xml_http_request :get, :advanced_search, @advanced_conditions, {:user_id => authorized_user.id}
    assert_response :success   
  end
  
  def test_advanced_search_logged_in
    authorized_user = user(:authorized_user)
    
    # by setting the user_id in the session the controller thinks the user
    # is logged in.
    @result = ViewHouseholdLoan.new_search()
   
    @result.conditions ={:street_name_keywords =>"108 PASCOE CT."}
    @result.conditions do |cond|
      cond.city = "Folsom"
      cond.zip_gte = "95626"
      cond.zip_lte = "95636"
      cond.property_count_gte = "1"
      cond.property_count_lte = "5"
      cond.purchase_price_in_cents_gte = "0"
      cond.purchase_price_in_cents_lte = "0"
      cond.housing_type_id = "3"
      cond.property_use_id = "1"
      cond.current_loan_amount_in_cents_gte = "7000000"
      cond.current_loan_amount_in_cents_lte = "34675000"
     
      cond.loan_to_value_percent_gte = "0"
      cond.loan_to_value_percent_lte = "0"
      cond.closing_date_gte = "10/31/2003"
      cond.closing_date_lte = "01/01/2004"
      cond.next_arm_rate_adjustment_date_gte = "01/01/2222"
      cond.next_arm_rate_adjustment_date_lte = "01/01/2222"
     
      #~ cond.end_of_intrest_only_period_gte = "01/01/2222"
      #~ cond.end_of_intrest_only_period_lte = "01/01/2222"
      cond.loan_type_id = "4"
      cond.age_years_gte = "30"
      cond.age_years_lte = "50"
      cond.age_years_gte = "30"
      cond.age_years_lte = "50"
      cond.user_id = '1'
    end
    @result.group = "id"  
    @result.page = 1  
    @result.per_page = @result.count
    @final=@result.all
    @result = "#{@final.map{|s| s.id}.join(',')}" 
    
    @searchresult = ViewHouseholdLoanSearchResult.find(:all, :conditions => "id IN (#{@result.size != 0 ? @result : 0})")
    
    xml_http_request :get, :advanced_search,{"search"=>{"conditions"=>
          {"street_name_keywords"=>"108 PASCOE CT.",    
          "city" => "Folsom",
          "zip_gte" => "95626",
          "zip_lte" => "95636",
          "property_count_gte" => "1",
          "property_count_lte" => "5",
          "purchase_price_in_cents_gte" => "0",
          "purchase_price_in_cents_lte" => "0",
          "housing_type_id" => "3",
          "property_use_id" => "1",
          "current_loan_amount_in_cents_gte" => "7000000",
          "current_loan_amount_in_cents_lte" => "34675000",
     
          "loan_to_value_percent_gte" => "0",
          "loan_to_value_percent_lte" => "0",
          "closing_date_gte" => "10/31/2003",
          "closing_date_lte" => "01/01/2004",
          "next_arm_rate_adjustment_date_gte" => "01/01/2222",
          "next_arm_rate_adjustment_date_lte" => "01/01/2222",
     
          #~ "end_of_intrest_only_period_gte" => "01/01/2222",
          #~ "end_of_intrest_only_period_lte" => "01/01/2222",
          "loan_type_id" => "4",
          "age_years_gte" => "30",
          "age_years_lte" => "50",
          "age_years_gte" => "30",
          "age_years_lte" => "50"
        }},"household"=>{"balloon_lte"=>"", "interest_gte"=>"", "balloon_gte"=>"", "interest_lte"=>""}}, {:user_id => authorized_user.id}
    assert_response :success 
  end
   
end

  
