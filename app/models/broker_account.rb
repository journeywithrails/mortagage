class BrokerAccount < ActiveRecord::Base
  set_table_name 'account'
  
  has_many :broker_users, :class_name => 'BrokerUser', :foreign_key => :account_id
  has_many :account_uploads, :class_name => 'AccountUpload', :foreign_key => :account_id
  has_many :households, :class_name => 'Household', :foreign_key => :account_id
  has_many :jobs, :class_name => 'Job', :foreign_key => :account_id
  has_many :head_of_hh_people, :through => :households_as_head_of_hh_person
  has_many :servers, :through => :jobs
  has_many :process_types, :through => :jobs
  has_many :job_status_types, :through => :jobs
  
  validates_length_of :name, :allow_nil => true, :maximum => 100
end
