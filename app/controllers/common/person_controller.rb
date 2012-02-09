class Common::PersonController < ApplicationController
  def initialize
    super
    self.subtab_nav = 'new_loan'
  end

  active_scaffold :person do |config|
    config.columns = [:first_name, :last_name, :phone_home, :phone_work, :phone_mobile, :fax, :email,
                      :address1, :address2, :city, :state, :zip, :household, 
                      :loans_as_borrower_person, :loans_as_co_borrower_person, :person_financials]
    
    config.list.columns = [:first_name, :last_name, :city, :state, :household, 
                      :loans_as_borrower_person, :person_financials]
       
    list.sorting = {:last_name => :desc}
    
    config.columns[:loans_as_borrower_person].includes = nil
    config.columns[:loans_as_co_borrower_person].includes = nil
    
    columns[:loans_as_borrower_person].label = "borrower's loans" 
    columns[:loans_as_co_borrower_person].label = "co-borrower's loans"
    columns[:person_financials].label = "financial history"
    columns[:phone_home].label = "home phone"
    columns[:phone_work].label = "work phone"
    columns[:phone_mobile].label = "mobile phone"
    
    config.actions = [:list, :nested, :show]
  end
  
end
