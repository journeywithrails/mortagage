class JobLogType < ActiveRecord::Base
  has_many :job_logs, :class_name => 'JobLog', :foreign_key => :job_log_type_id
  has_many :jobs, :through => :job_logs
  validates_presence_of :name
  validates_length_of :name, :allow_nil => false, :maximum => 50
  
end
