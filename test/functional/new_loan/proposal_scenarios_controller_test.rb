require 'test_helper'

class NewLoan::ProposalScenariosControllerTest < ActionController::TestCase
  #fixtures :proposal, :proposal_scenario, :loan, :proposal_scenario_loan, :household, :person, :person_financial
  def setup
    load_user
  end
  
  def test_invalid_param_redirects_to_proposal_list
    get :edit, {:id => proposal_scenario(:first_scenario_for_other_broker).id}, {:user_id => broker_user(:authorized_user).id}
    assert_redirected_to new_loan_proposals_path
  end

  def test_valid_param_gives_success
    get :edit, {:proposal_id => proposal(:guiliani_apartment).id, :id => proposal_scenario(:guiliani_thirty_year_fixed).id}, {:user_id => broker_user(:authorized_user).id}
    assert_response :success
  end

  def test_show
   get :show, {:proposal_id => proposal(:guiliani_apartment).id, :id => proposal_scenario(:guiliani_thirty_year_fixed).id}, {:user_id => broker_user(:authorized_user).id}
   assert_response :success
  end

  def test_index
    get :index, {:proposal_id => proposal(:guiliani_apartment).id},  {:user_id => broker_user(:authorized_user).id}
    assert_response :success
  end
  
  def test_new
    get :new, {:proposal_id => proposal(:guiliani_apartment).id},  {:user_id => broker_user(:authorized_user).id}
    assert_response :success  
  end  
  
  def test_index_with_factory
    proposal = Factory(:proposal, :user => broker_user(:authorized_user))
    5.times do
    Factory(:household_financial, :household_id => proposal.household.id)
    end
    proposal_scenario = Factory(:proposal_scenario, :proposal_id => proposal.id)
    loan = Factory(:loan)
    proposal_scenario_loan = Factory(:proposal_scenario_loan, :proposal_scenario_id =>proposal_scenario.id,:loan_id => loan.id)
    #proposal.household.household_financials << Factory(:household_financial)
    #proposal.household.household_financials.last.tax_rate = Factory(:tax_rate)
    #proposal_scenario = Factory(:proposal_scenario, :proposal => proposal, :loans => [Factory(:loan, :co_borrower_person => Factory(:person))])
    #proposal.proposal_scenarios << proposal_scenario
    get :index, {:proposal_id => proposal.id},  {:user_id => broker_user(:authorized_user).id}
    assert_response :success  
    assert_not_nil assigns(:head_of_hh_person)
  end
  
end
