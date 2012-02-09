class Admin::CostTypeController < AdminController
  active_scaffold :cost_type do |config|
    config.columns = [:name]
    list.sorting = {:name => :desc}
    config.actions.exclude :search
  end
end
