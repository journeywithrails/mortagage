class NewLoan::ProposalScenariosController < NewLoanController
  include ProposalUtils
  before_filter :load_data

  def index
  end

  def edit
  end
  
  def update
    update_method = "update_attributes!" 
    update_method = "attributes=" if request.xhr?
    update_error = false
    begin
      Proposal.transaction do
        if @first_loan.new_record?
          @first_loan = Loan.new(params[:first_loan])
          @first_loan.user_id = current_broker_user.id
          @first_loan.save! unless request.xhr?
          @proposal_scenario.loans << @first_loan
        else
          @first_loan.send(update_method, params[:first_loan])
        end

        if @second_loan.new_record? && params[:second_loan][:loan_amount]
          @second_loan = Loan.new(params[:second_loan])
          if @second_loan.loan_amount.to_i > 0
            @second_loan.user_id = current_broker_user.id
            @second_loan.property = @proposal_property
            @second_loan.borrower_person = @head_of_hh_person
            @second_loan.co_borrower_person = @coborrower if @coborrower
            @second_loan.save! unless request.xhr?
            @proposal_scenario.loans << @second_loan
          end
        elsif !@second_loan.new_record?
          @second_loan.send(update_method, params[:second_loan])
        end

        @title_fee_scenario.send(update_method, params[:title_fee_scenario])
        @closing_scenario.send(update_method, params[:closing_scenario])
        @proposal_scenario.send(update_method, params[:proposal_scenario])
        flash[:notice] = "Proposal Updated"
      end
    rescue
      flash[:notice] = "Error updating loan proposal #{$!.to_s}" unless request.xhr?
      logger.debug $!.to_s << ' ' << $!.backtrace.join("\n");
      update_error = true
    end
    respond_to do |format|
      format.xml { head :ok} if request.xhr?

      format.html do 
        if update_error
          redirect_to edit_new_loan_proposal_proposal_scenario_path(@proposal, @proposal_scenario)
          return
        end
        redirect_to edit_new_loan_proposal_path(@proposal) if params[:submit_button] == 'save_and_return'
        redirect_to new_new_loan_proposal_proposal_scenario_path(@proposal) if params[:submit_button] == 'save_and_create_new'
        redirect_to new_loan_proposal_proposal_scenario_path(@proposal, @proposal_scenario) if params[:submit_button] == 'save_and_continue'
      end unless request.xhr?

      format.js do
        render :update do |page|
          page.replace_html 'form_fields', :partial => 'form_fields'
          page.visual_effect :highlight, "#{@first_loan.class.name.underscore}_#{@first_loan.id}_monthly_payment"
        end
      end
    end
  end

  def show
  end

  def new
    #TODO: This method should present an empty form for the user to populate. When the
    # user clicks 'save' the create action should be executed
    @proposal_scenario = ProposalScenario.new()
    @proposal_scenario.name = @proposal.name
    @proposal_scenario.proposal = @proposal
    @proposal_scenario.build_title_fee_scenario
    @proposal_scenario.build_closing_scenario    
    
    @first_loan = Loan.new(:user_id => current_broker_user.id, :loan_status_id => LoanStatus::Proposed)
    @first_loan.co_borrower_person = @coborrower
    @first_loan.property = @proposal_property
    @first_loan.borrower_person = @head_of_hh_person

    @proposal_scenario.loans << @first_loan    
  end
  
  def create
    #TODO: This method will receive the form variables, create the appropriate objects
    # and then redirect to the show action.   
  end
  
  private
  def load_data
    begin
      @proposal = current_broker_user.proposals.find(params[:proposal_id])
      session[:proposal_id] =  @proposal.id 
      if params[:id]
        @proposal_scenario = @proposal.proposal_scenarios.find(params[:id])
        @title_fee_scenario = @proposal_scenario.title_fee_scenario
        @closing_scenario = @proposal_scenario.closing_scenario
        load_loans
      end
      extract_objects_from_proposal
    rescue ActiveRecord::RecordNotFound => e
      redirect_to new_loan_proposals_path
    end
  end

  def load_loans
    if @proposal_scenario.loans.length > 0
      @first_loan = @proposal_scenario.loans.first
    else
      @first_loan = Loan.new()
    end

    if @proposal_scenario.loans.length > 1
      @second_loan = @proposal_scenario.loans[1]
    else
      @second_loan = Loan.new()
    end
  end
end
