class TaskClass < ActiveRecord::Base
  has_many :jobs, :class_name => 'Job', :foreign_key => :task_class_id
  has_many :server_task_class_counts, :class_name => 'ServerTaskClassCount', :foreign_key => :task_class_id

  validates_presence_of :name
  validates_length_of :name, :allow_nil => false, :maximum => 45
end
