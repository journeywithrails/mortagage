class Portfolio::TopCustomersController < PortfolioController

  active_scaffold :view_person_loan do |config|
    config.actions = [:list]
    config.columns = [:top_customer, :no_of_loans, :total_loans_in_thousands]
    list.per_page = 10
   
    config.columns[:total_loans_in_thousands].sort_by :sql => "total_loans_in_cents"
    list.sorting = { :total_loans_in_thousands => :desc }

    columns[:top_customer].label = "Borrower"
    columns[:no_of_loans].label = "Number Of Loans"    
    columns[:total_loans_in_thousands].label = "Total Loan Size($000s)"
    columns[:no_of_loans].css_class = "text_center_align"
    columns[:total_loans_in_thousands].css_class = "text_right_align"

  end

  def conditions_for_collection
    ['user_id = ?', current_broker_user.id]
  end

end
