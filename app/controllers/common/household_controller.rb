class Common::HouseholdController < ApplicationController

  active_scaffold :household do |config|
    config.columns = [:head_of_hh_person, :people, :proposals, :properties]
    
    config.columns[:properties].includes = nil
    
    columns[:head_of_hh_person].label = "Head of Household"

    config.actions = [:list, :nested]
  end
  
end
