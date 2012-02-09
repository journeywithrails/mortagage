module ProposalUtils
  protected 
  def extract_objects_from_proposal
    @head_of_hh_person = @proposal.household.head_of_hh_person
    @proposal_property = @proposal.property
    @household_financial = @proposal.household.household_financials.last
    @person_financial = @head_of_hh_person.person_financials.last
    @coborrower = @proposal.proposal_scenarios.last.loans.last.co_borrower_person
  end
end
