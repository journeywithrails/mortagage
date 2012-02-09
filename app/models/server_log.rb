class ServerLog < ActiveRecord::Base
  belongs_to :server, :class_name => 'Server', :foreign_key => :server_id
  belongs_to :server_log_type, :class_name => 'ServerLogType', :foreign_key => :server_log_type_id

  validates_presence_of :message
  validates_length_of :class_name, :allow_nil => true, :maximum => 128
  
  def to_label
    "#{message}"
  end
end
