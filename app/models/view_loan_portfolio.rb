class ViewLoanPortfolio < ActiveRecord::Base
  def avg_loans_per_household
    closed_loans.to_f / active_loan_households.to_f
  end
end
