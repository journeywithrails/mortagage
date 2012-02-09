module Portfolio::ViewHouseholdLoanSearchResultHelper
  def name_column(record)
    logger.debug "*********** Calling names_matching_search for params #{params.to_yaml}\n"
    household_overview_link(record, "#{record.names_matching_search(params)}")
  end

  def address_column(record)
    logger.debug "*********** Calling address_matching_search for params #{params.to_yaml}\n"
    household_overview_link(record, "#{record.addresses_matching_search(params)}")
  end
  
  def avg_loan_size_column(record)
    household_overview_link(record, number_to_currency(record.avg_loan_size, :precision => 0))
  end
  
  def total_monthly_payments_column(record)
    household_overview_link(record,number_to_currency(record.total_monthly_payments, :precision => 0))
  end
  
  def total_loans_column(record)
    household_overview_link(record,number_to_currency(record.total_loans, :precision => 0))
  end

  def property_count_column(record)
    household_overview_link(record, "#{record.property_count}")
  end
  
end

