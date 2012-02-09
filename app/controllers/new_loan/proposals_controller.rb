class NewLoan::ProposalsController < NewLoanController
  include ProposalUtils
  before_filter :load_data, :except => [:do_search]
  
  active_scaffold :proposal do |config|
        config.columns = [:name, :household, :property, :proposal_scenarios, :updated_at]
        config.columns[:proposal_scenarios].label = "scenarios"
        list.sorting = {:updated_at => :desc}    
        config.actions = [:list] 
  end

  def conditions_for_collection
    ['proposal.user_id = ?', current_broker_user.id]
  end
  
  def index
    create_user_search
    build_conditions   
  end  
  
  def do_search
    @search = Proposal.new_search(params[:search])
    # as active scaffold is going to append the condition from the method "conditions_for_collection". so no need to add this condition 
    #@search.conditions.user_id = current_broker_user.id
    build_conditions
    render :update do |page|
      page.replace_html 'search_results'
      page.replace_html 'search_results', :partial => 'search_results'
    end       
  end  

  def new
    @coborrower = Person.new
    @proposal = Proposal.new
    @head_of_hh_person = Person.new
    @proposal_property = Property.new
    @household_financial = HouseholdFinancial.new
    @household_financial.build_tax_rate
    @person_financial = PersonFinancial.new
  end

  def create
    begin
      Household.transaction do
        @head_of_hh_person = Person.new(params[:head_of_hh_person])
        @household_financial = HouseholdFinancial.new(params[:household_financial])
        @person_financial = PersonFinancial.new(params[:person_financial])
        @proposal_property = Property.new(params[:proposal_property])

        @proposal = Proposal.new(params[:proposal])
        @coborrower = Person.new(params[:coborrower])

        hh = Household.new(:user_id => current_user.id, :account_id => current_account.id)
        hh.save! 

        @head_of_hh_person.household = hh
        @head_of_hh_person.save!
        hh.head_of_hh_person = @head_of_hh_person
        hh.save!


        @household_financial.household = hh
        @household_financial.save!

        @person_financial.person = @head_of_hh_person
        @person_financial.save!

        @proposal_property.household = hh
        @proposal_property.save!

        @proposal.property = @proposal_property
        @proposal.household = hh
        @proposal.name = @proposal.household.head_of_hh_person.first_name.to_s + Time.now.to_s(:short)
        @proposal.user = current_broker_user
        @proposal.save!

        @proposal_scenario = ProposalScenario.new
        @proposal_scenario.name = @proposal.name
        @proposal_scenario.proposal = @proposal
        @proposal_scenario.build_title_fee_scenario
        @proposal_scenario.build_closing_scenario
        @proposal_scenario.save!
        
        @first_loan = Loan.new(:user_id => current_broker_user.id, :loan_status_id => LoanStatus::Proposed)
        @first_loan.co_borrower_person = @coborrower
        @first_loan.property = @proposal_property
        @first_loan.borrower_person = @head_of_hh_person

        @proposal_scenario.loans << @first_loan

        flash[:notice] = "Created proposal"
        session[:proposal_id] = @proposal.id
      end
      redirect_to edit_new_loan_proposal_proposal_scenario_path(@proposal_scenario.proposal.id, @proposal_scenario.id)
    rescue Exception 
      flash[:notice] = "Error creating proposal. #{$!.to_s}"
      render :action => :new
    end
  end

  def edit
    extract_objects_from_proposal
  end

  def update
    extract_objects_from_proposal

    begin
      Proposal.transaction do 
        @head_of_hh_person.update_attributes!(params[:head_of_hh_person])
        @household_financial.update_attributes!(params[:household_financial])
        @person_financial.update_attributes!(params[:person_financial])
        @proposal_property.update_attributes!(params[:proposal_property])
        @coborrower.update_attributes!(params[:coborrower])
      end
      flash[:notice] = 'Proposal Updated'
      redirect_to edit_new_loan_proposal_proposal_scenario_path(@proposal, @proposal.proposal_scenarios.first)
    rescue
      flash[:error] = 'Error updating proposal ' + $!.to_s
      logger.debug $!.to_s << ' ' << $!.backtrace.join("\n")
      render :action => :edit
    end
  end
  
  private
 
  def create_user_search
    @search = Proposal.new_search()
  end
  
  def build_conditions
    @conditions = @search.sanitize[:conditions]
  end
  
  def load_data
    session[:proposal_id] = nil
    if params[:id]
      begin
        @proposal = current_broker_user.proposals.find(params[:id])
        session[:proposal_id] = @proposal.id
      rescue ActiveRecord::RecordNotFound => e
        redirect_to new_loan_proposals_path
        return
      end
    end
  end
end 