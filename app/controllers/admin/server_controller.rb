class Admin::ServerController < AdminController
    
  active_scaffold :server do |config|
    config.columns = [:hostname, :is_active, :process_types, :server_properties]
    list.sorting = {:hostname => :desc}
  end
end
