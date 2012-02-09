class Admin::ProcessTypeController < AdminController
      
  active_scaffold :process_type do |config|
    config.columns = [:name, :process_type_properties, :servers]
  end  
  
end
