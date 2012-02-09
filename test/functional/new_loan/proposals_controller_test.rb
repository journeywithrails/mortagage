require 'test_helper'

class NewLoan::ProposalsControllerTest < ActionController::TestCase
  fixtures :person, :household, :proposal, :proposal_scenario, :loan, :proposal_scenario_loan, :household_financial, :property
  def setup
    load_user
  end
  
  def test_new_not_logged_in
    get :new
    assert_redirected_to new_session_path
  end

  def test_new
    get :new, {}, {:user_id => user(:authorized_user).id}
    assert_response :success
  end

  def test_create
    post :create, {}, {:user_id => user(:authorized_user).id}
    assert_redirected_to 
  end

  def test_edit
    get :edit, {:id => proposal(:guiliani_apartment).id}, {:user_id => user(:authorized_user).id}
    assert_response :success
  end
  
  def test_update
    proposal = Factory(:proposal, :user => broker_user(:authorized_user))
    proposal.household.household_financials << Factory(:household_financial)
    proposal.household.household_financials.last.tax_rate = Factory(:tax_rate)
    proposal_scenario = Factory(:proposal_scenario, :proposal => proposal, :loans => [Factory(:loan, :co_borrower_person => Factory(:person))])
    proposal.proposal_scenarios << proposal_scenario

    put :update, {:id => proposal.id, 
      :head_of_hh_person => Factory.attributes_for(:person),
      :household_financial => Factory.attributes_for(:household_financial),
      :person_financial => Factory.attributes_for(:person_financial),
      :proposal_property => Factory.attributes_for(:property),
      :coborrower => Factory.attributes_for(:person)
    }, {:user_id => proposal.user.id}
    assert_redirected_to edit_new_loan_proposal_proposal_scenario_path(proposal, proposal.proposal_scenarios.first)
  end
  
  def test_index
    get :index, {}, {:user_id => user(:authorized_user).id}
    assert_response :success
  end
  
  def test_do_search_with_all_blank
    conditions = {:search => {:conditions => {:name_like => "",:updated_at_gte => "",:updated_at_lte => ""}}}
    xml_http_request :get, :do_search, conditions, {:user_id => user(:authorized_user).id}
    assert_response :success 
    assert_tag :content => /Rudolph/  
    assert_tag :content => /Chue/ 
    assert_tag :content => /Boulder, CO/ 
    assert_no_tag :content => /123 Main St/
  end
  
  def test_do_search_with_name
    conditions = {:search => {:conditions => {:name_like => "Rudolph",:updated_at_gte => "",:updated_at_lte => ""}}}
    xml_http_request :get, :do_search, conditions, {:user_id => user(:authorized_user).id}
    assert_response :success 
    assert_tag :content => /Rudolph/  
    assert_no_tag :content => /Clint/    
  end
  
  def test_do_search_with_from_date_to_date
    conditions = {:search => {:conditions => {:name_like => "",:updated_at_gte => "April 1, 2009",:updated_at_lte => "April 3, 2009"}}}
    xml_http_request :get, :do_search, conditions, {:user_id => user(:authorized_user).id}
    assert_response :success 
    assert_tag :content => /Rudolph/  
    assert_tag :content => /Chue/
    assert_no_tag :content => /Clint/    
  end
  
  def test_do_search_with_name_from_date_to_date
    conditions = {:search => {:conditions => {:name_like => "Rudolph",:updated_at_gte => "April 1, 2009",:updated_at_lte => "April 3, 2009"}}}
    xml_http_request :get, :do_search, conditions, {:user_id => user(:authorized_user).id}
    assert_response :success 
    assert_tag :content => /Rudolph/  
    assert_no_tag :content => /Chue/ 
    assert_no_tag :content => /Clint/
  end


  
end
