class Server < ActiveRecord::Base
  require "socket"
  
  has_many :jobs, :class_name => 'Job', :foreign_key => :server_id
  has_many :server_logs, :class_name => 'ServerLog', :foreign_key => :server_id
  has_many :server_process_maps, :class_name => 'ServerProcessMap', :foreign_key => :server_id
  has_many :server_properties, :class_name => 'ServerProperty', :foreign_key => :server_id
  has_many :server_task_class_counts, :class_name => 'ServerTaskClassCount', :foreign_key => :server_id
  has_many :accounts, :through => :jobs
  has_many :process_types, :through => :jobs
  has_many :users, :through => :jobs
  has_many :job_status_types, :through => :jobs
  has_many :server_log_types, :through => :server_logs
  has_many :process_types, :through => :server_process_maps
  
  validates_presence_of :hostname
  validates_length_of :hostname, :allow_nil => false, :maximum => 100
  validates_inclusion_of :is_active, :in => [true, false], :allow_nil => false, :message => ActiveRecord::Errors.default_error_messages[:blank]
  
  def to_label
    "#{hostname}"
  end  
  
  def self.current
    @@current_server ||= self.find( :first, :conditions => { :hostname => Socket::gethostname.downcase } )
  end
  
end
