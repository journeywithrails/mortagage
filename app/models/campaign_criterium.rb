class CampaignCriterium < ActiveRecord::Base
  set_table_name "campaign_criteria" 
  
  belongs_to :campaign, :class_name => 'Campaign', :foreign_key => :campaign_id
  
  validates_presence_of :column_name
  validates_length_of :column_name, :allow_nil => false, :maximum => 50
  validates_length_of :column_value, :allow_nil => true, :maximum => 80
end
