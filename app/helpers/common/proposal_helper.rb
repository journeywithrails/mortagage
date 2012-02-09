module Common::ProposalHelper
  def name_column(proposal)
    link_to(h(proposal.name), :controller => 'new_loan/proposals', :action => 'edit', :id => proposal.id)
  end
  
end
