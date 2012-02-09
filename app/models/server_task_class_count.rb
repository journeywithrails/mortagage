class ServerTaskClassCount < ActiveRecord::Base
  belongs_to :server, :class_name => 'Server', :foreign_key => :server_id
  belongs_to :task_class, :class_name => 'TaskClass', :foreign_key => :task_class_id

  validates_presence_of :thread_count
  validates_numericality_of :thread_count, :allow_nil => false, :only_integer => true
end
