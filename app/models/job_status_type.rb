class JobStatusType < ActiveRecord::Base
  has_many :job, :class_name => 'Job', :foreign_key => :job_status_type_id
  has_many :server, :through => :jobs
  has_many :account, :through => :jobs
  has_many :process_type, :through => :jobs
  validates_presence_of :name
  validates_length_of :name, :allow_nil => false, :maximum => 50
end
