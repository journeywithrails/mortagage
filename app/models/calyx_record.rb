class CalyxRecord < ActiveRecord::Base
#  belongs_to :account_upload, :class_name => 'AccountUpload', :foreign_key => :account_upload_id
  has_many :calyx_fields, :class_name => 'CalyxField', :foreign_key => :calyx_record_id
  
  validates_length_of :calyx_guid, :allow_nil => true, :maximum => 45
end
