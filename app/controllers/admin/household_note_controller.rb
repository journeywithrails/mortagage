class Admin::HouseholdNoteController < AdminController
  
  active_scaffold :household_note do |config|
    config.columns = [:note]
  end 

end
