class UploadStatus < ActiveRecord::Base
  has_many :account_upload_as_upload_status, :class_name => 'AccountUpload', :foreign_key => :upload_status_id
  has_many :account, :through => :account_upload
  
  validates_presence_of :name
  validates_length_of :name, :allow_nil => false, :maximum => 50
end
