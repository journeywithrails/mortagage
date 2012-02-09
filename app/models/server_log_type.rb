class ServerLogType < ActiveRecord::Base
  has_many :server_logs, :class_name => 'ServerLog', :foreign_key => :server_log_type_id
  has_many :servers, :through => :server_logs
  validates_presence_of :name
  validates_length_of :name, :allow_nil => false, :maximum => 50
end
