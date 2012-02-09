class Job < ActiveRecord::Base
  belongs_to :account, :class_name => 'BrokerAccount', :foreign_key => :account_id
  belongs_to :user, :class_name => 'BrokerUser', :foreign_key => :user_id
  belongs_to :job_status_type, :class_name => 'JobStatusType', :foreign_key => :job_status_type_id
  belongs_to :server, :class_name => 'Server', :foreign_key => :server_id
  belongs_to :process_type, :class_name => 'ProcessType', :foreign_key => :process_type_id
  belongs_to :task_class, :class_name => 'TaskClass', :foreign_key => :task_class_id
  has_many :job_logs, :class_name => 'JobLog', :foreign_key => :job_id
  has_many :job_log_types, :through => :job_logs

  before_create :default_process_type
  
  def to_label
    "#{id}: #{process_type.name}"
  end    

  private
  def default_process_type
    self.task_class_id = 3 unless self.task_class_id
  end
  
end
