class ServerProcessMap < ActiveRecord::Base
  belongs_to :server, :class_name => 'Server', :foreign_key => :server_id
  belongs_to :process_type, :class_name => 'ProcessType', :foreign_key => :process_type_id
end
