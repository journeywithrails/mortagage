class CampaignChannel < ActiveRecord::Base
  has_many :campaigns, :class_name => 'Campaign', :foreign_key => :campaign_channel_id
  
  validates_presence_of :name
  validates_length_of :name, :allow_nil => false, :maximum => 20
end
