class Admin::JobController < AdminController
  
  active_scaffold :job do |config|
    config.actions.exclude :create, :update, :delete, :search
    config.columns = [:id, :account, :server, :process_type, :job_status_type, :job_logs, :task_class]
    config.columns[:account].clear_link
    list.sorting = {:id => :desc}
    list.per_page = 40
  end
  
end
