class Admin::LoanController < AdminController
      
  active_scaffold :loan do |config|
    config.columns = [:property, :borrower_person, :co_borrower_person, :loan_type, :loan_rank, :is_active, :loan_status,
                      :amortization_schedule, :loan_amount, :rate, :note_rate, :margin_rate, :index_code, :closing_date, 
                      :first_payment_date, :final_balloon_payment_date, :final_balloon_payment, :loan_term_periods, 
                      :loan_due_in_periods, :fixed_payment_periods, :loan_type_details, :first_adjustment_rate_cap, 
                      :periodic_adjustment_rate_cap, :lifetime_interest_rate_cap, :lifetime_interest_rate_floor,
                      :first_adjustment_cap, :payment_adjustment_period, :biweekly_payments]
                      
    config.list.columns = [:property, :borrower_person, :co_borrower_person, :loan_type, :is_active, :loan_status,
                      :amortization_schedule, :loan_amount, :note_rate, :closing_date]
                      
    config.columns[:amortization_schedule].includes = nil
    config.columns[:property].sort = false
    config.columns[:co_borrower_person].sort = false
    config.columns[:loan_rank].sort = false
    config.columns[:amortization_schedule].sort = false
    config.columns[:borrower_person].sort_by :method => 'borrower_person.last_name'
    config.columns[:loan_type].sort_by :method => 'loan_type.name'
    columns[:borrower_person].label = "Borrower"
    columns[:co_borrower_person].label = "Co-Borrower"
    #    config.columns[:co_borrower_person].association.reverse = :loan
    config.columns[:rate].clear_link
    config.actions.exclude :create, :delete, :update
  end
  
end
