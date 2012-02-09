class Admin::ServerLogController < AdminController
    
  active_scaffold :server_log do |config|
    config.columns = [:server, :server_log_type, :message, :class_name, :stack_trace, :created_at]
    list.sorting = {:created_at => :desc}
  end
  
end
