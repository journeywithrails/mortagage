class Common::AmortizationScheduleController < ApplicationController
    
  active_scaffold :amortization_schedule do |config|
    config.columns = [:period, :rate, :interest, :principle, :remaining_bal, :period_start_date]
    columns[:principle].label = "Principal"
    list.per_page = 60
    list.sorting = {:period_start_date => :asc}
    config.actions.exclude :create, :delete, :update, :show, :search
  end 

end
