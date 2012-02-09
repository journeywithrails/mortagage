class CalyxField < ActiveRecord::Base
  belongs_to :calyx_record, :class_name => 'CalyxRecord', :foreign_key => :calyx_record_id
  validates_presence_of :value
end
