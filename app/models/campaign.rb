class Campaign < ActiveRecord::Base
  belongs_to :user, :class_name => 'BrokerUser', :foreign_key => :user_id
  belongs_to :campaign_channel, :class_name => 'CampaignChannel', :foreign_key => :campaign_channel_id

  has_many :campaign_criteria, :class_name => 'CampaignCriterium', :foreign_key => :campaign_id
  has_many :household_reports, :class_name => 'HouseholdReport', :foreign_key => :campaign_id

  validates_presence_of :name
  validates_length_of :name, :allow_nil => false, :maximum => 80

end
