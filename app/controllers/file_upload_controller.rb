require 'fileutils'

class FileUploadController < ApplicationController
  
#<stageCalyxData class="com.somispo.tasks.StageCalyxData" fileName="/home/gxs/Public/calyx.spo" uploadDate="2008-06-25 20:27:30.515 MDT" accountId="1" userId="1"/>  
  
  STAGE_CALYX_DATA_CLASS = "com.somispo.tasks.StageCalyxData"
  JOB_STATUS_QUEUED = 1
  PROCESS_TYPE_GENERAL = 1
  GLOBAL_PROPERTY_NAME_UPLOAD_ROOT = "UploadRoot"
  GLOBAL_PROPERTY_NAME_USER_FILES_ROOT = "UserFilesRoot"
  
  def initialize
    super
    self.subtab_nav = "blank"
  end
  
  def new
  end
  
  def create
    upload_root = GlobalProperty.find_by_name(GLOBAL_PROPERTY_NAME_UPLOAD_ROOT).property_value
    uploaded_file = File.join(upload_root, params[:filename])

    user_files_root = GlobalProperty.find_by_name(GLOBAL_PROPERTY_NAME_USER_FILES_ROOT).property_value
    target_path = File.join(user_files_root, current_user.id.to_s)
    filename = Time.new.strftime("%Y-%m-%d-%H-%M-%S")

    if !File.exists?(target_path)
        FileUtils.mkpath(target_path)
    end
    
    user_file = File.join(target_path, filename)
    
    FileUtils.mv uploaded_file, user_file
        
    queue_stage_calyx_data_job(user_file)
  end

  
  private
  
  def queue_stage_calyx_data_job(filename)
    # date format expected: 2008-08-06 14:27:30.515 MDT
    
    xml_spec = sprintf("<stageCalyxData class=\"%s\" fileName=\"%s\" uploadDate=\"%s\" accountId=\"%d\" userId=\"%s\"\/>",
                      STAGE_CALYX_DATA_CLASS,
                      filename,
                      Time.new.strftime("%Y-%m-%d %H:%M:%S MDT"),
                      current_account.id,
                      current_user.id)
    
    @job = Job.new( :process_type_id => PROCESS_TYPE_GENERAL, 
                    :account_id => current_account.id, 
                    :user_id => current_user.id,
                    :server_id => current_server.id, 
                    :job_status_type_id => JOB_STATUS_QUEUED, 
                    :job_specification => xml_spec)
    @job.save
  end
  
end
