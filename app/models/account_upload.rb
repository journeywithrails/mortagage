class AccountUpload < ActiveRecord::Base
  belongs_to :account, :class_name => 'BrokerAccount', :foreign_key => :account_id
  belongs_to :user, :class_name => 'BrokerUser', :foreign_key => :user_id
  belongs_to :upload_status, :class_name => 'UploadStatus', :foreign_key => :upload_status_id
  
  
  validates_presence_of :upload_date_time  
  
  def to_label
    "#{account.name} - #{upload_date_time}"
  end
end
