module NewLoan::ProposalsHelper
  def ajax_args()
      {:url => get_tax_rate_path, :update => {:failure => 'error'}, :with => "'household_financial_estimated_income=' + encodeURIComponent($F('household_financial_estimated_income')) + '&tax_filing_status_id=' + encodeURIComponent($F('tax_filing_status_id'))"} 
  end

  def name_column(record)
    link_to h(record.name), edit_new_loan_proposal_path(record)
  end

 def household_column(record)
   link_to(h(record.household.to_label), edit_new_loan_proposal_path(record)) unless record.household.nil? 
 end

 def property_column(record)
   link_to(h(record.property.property_address), edit_new_loan_proposal_path(record)) unless record.property.nil? 
 end
 
 def updated_at_column(record)
   link_to h(record.updated_at), edit_new_loan_proposal_path(record)
 end
 
end
