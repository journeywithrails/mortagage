class Admin::ClosingScenarioController < AdminController  
  active_scaffold :closing_scenario do |config|
    list.sorting = {:name => :desc}
    config.actions.exclude :search
  end 
end
