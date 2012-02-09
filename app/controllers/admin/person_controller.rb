class Admin::PersonController < AdminController
 
  active_scaffold :person do |config|
    config.columns = [:first_name, :middle_name, :last_name, :ssn, 
                      :phone_home, :phone_work, :phone_mobile, :fax, :email,
                      :address1, :address2, :city, :state, :zip, :household, 
                      :loans_as_borrower_person, :loans_as_co_borrower_person, :person_financials]

    config.list.columns = [:first_name, :last_name, :ssn, 
                      :address1, :city, :state, :zip, :household, 
                      :loans_as_borrower_person, :loans_as_co_borrower_person, :person_financials ]
    
    list.sorting = {:last_name => :desc}
    config.columns[:loans_as_borrower_person].includes = nil
    config.columns[:loans_as_co_borrower_person].includes = nil
    
    columns[:loans_as_borrower_person].label = "borrower's loans" 
    columns[:loans_as_co_borrower_person].label = "co-borrower's loans"
    columns[:person_financials].label = "financial history"
    columns[:phone_home].label = "home phone"
    columns[:phone_work].label = "work phone"
    columns[:phone_mobile].label = "mobile phone"

    config.actions.exclude  :delete
  end
  
end
