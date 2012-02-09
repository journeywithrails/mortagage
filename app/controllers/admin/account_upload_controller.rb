class Admin::AccountUploadController < AdminController
   
  active_scaffold :account_upload do |config|
    config.columns = [:account, :upload_status, :upload_date_time]
    config.columns[:account].clear_link
    list.sorting = {:upload_date_time => :desc}
    config.actions.exclude :create, :show, :delete, :search
  end 
  
end
