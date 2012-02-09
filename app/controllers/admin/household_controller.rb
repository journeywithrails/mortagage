class Admin::HouseholdController < AdminController
  
  active_scaffold :household do |config|
    config.columns = [:account, :head_of_hh_person, :people, :proposals, :properties, :household_financials, :household_notes]
    config.columns[:properties].includes = nil
    config.columns[:head_of_hh_person].includes = nil
    config.columns[:account].clear_link
    columns[:head_of_hh_person].label = "Head of Household"
    config.actions.exclude :delete
  end 

end
