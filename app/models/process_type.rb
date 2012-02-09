class ProcessType < ActiveRecord::Base
  has_many :jobs, :class_name => 'Job', :foreign_key => :process_type_id
  has_many :process_type_properties, :class_name => 'ProcessTypeProperty', :foreign_key => :process_type_id
  has_many :server_process_maps, :class_name => 'ServerProcessMap', :foreign_key => :process_type_id
  has_many :servers, :through => :jobs
  has_many :accounts, :through => :jobs
  has_many :users, :through => :jobs
  has_many :job_status_types, :through => :jobs
  has_many :servers, :through => :server_process_maps
  
  validates_presence_of :name
  validates_length_of :name, :allow_nil => false, :maximum => 50
  validates_length_of :class_name, :allow_nil => true, :maximum => 255
end
