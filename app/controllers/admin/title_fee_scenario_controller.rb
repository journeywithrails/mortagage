class Admin::TitleFeeScenarioController < AdminController
  active_scaffold :title_fee_scenario do |config|
    list.sorting = {:name => :desc}
  end   
end
