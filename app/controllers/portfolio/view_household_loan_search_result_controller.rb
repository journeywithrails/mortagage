class Portfolio::ViewHouseholdLoanSearchResultController < PortfolioController
  active_scaffold :view_household_loan_search_result do |config|
    config.actions = [:list]
    config.columns = [:name, :address, :property_count, :avg_loan_size, :total_monthly_payments, :total_loans]

    config.columns[:property_count].label = "# of Properties"
    config.columns[:avg_loan_size].label = "Avg Loan Size"
    config.columns[:total_monthly_payments].label = "Total Monthly Payments"
    config.columns[:total_loans].label = "Total Loans"
    config.columns[:total_loans].sort_by :sql => "total_loans_in_cents"
    config.columns[:total_monthly_payments].sort_by :sql => "total_monthly_payments_in_cents"
    config.columns[:avg_loan_size].sort_by :sql => "avg_loan_size_in_cents"
    
    config.columns[:property_count].css_class = "text_center_align"
    config.columns[:avg_loan_size].css_class = "text_center_align"
    config.columns[:total_monthly_payments].css_class = "text_center_align"
    config.columns[:total_loans].css_class = "text_center_align"

    config.columns[:name].sort = false
    config.columns[:address].sort = false

    config.list.no_entries_message = "No households were found matching your search criteria."

    # list.sorting = {:household_name => :asc}
    list.per_page = 25
  end

  def joins_for_collection
    "view_household_loan"
  end

  def group_for_collection
    "view_household_loan_search_result.id"
  end

end
