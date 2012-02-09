class JobLog < ActiveRecord::Base
  belongs_to :job, :class_name => 'Job', :foreign_key => :job_id
  belongs_to :job_log_type, :class_name => 'JobLogType', :foreign_key => :job_log_type_id
  
  def to_label
    "#{message[0,15]}"
  end
end
