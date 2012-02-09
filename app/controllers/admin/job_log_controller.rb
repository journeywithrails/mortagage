class Admin::JobLogController < AdminController
    
  active_scaffold :job_log do |config|
    config.columns = [:job, :job_log_type, :message, :stack_trace, :created_at]
    config.columns[:job_log_type].clear_link
    list.sorting = {:created_at => :desc}
    config.actions.exclude :search, :create
  end 
end
