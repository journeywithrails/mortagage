class HouseholdReport < ActiveRecord::Base
  belongs_to :refi_scenario, :class_name => 'RefiScenario', :foreign_key => :refi_scenario_id
  belongs_to :campaign, :class_name => 'Campaign', :foreign_key => :campaign_id
  belongs_to :user, :class_name => 'BrokerUser', :foreign_key => :user_id
  belongs_to :household, :class_name => 'Household', :foreign_key => :household_id
  belongs_to :opportunity_type, :class_name => 'OpportunityType', :foreign_key => :opportunity_type_id
  
  validates_length_of :report_file, :allow_nil => true, :maximum => 255
  
  file_column :report_file
  
  attr_accessible :delete_report_file
  attr_accessor :delete_report_file
  
  # need for file_column voodoo (from active_scaffold/lib/bridges/file_column.lib/file_column_helpers.rb)
  def delete_report_file=(value)
    value = (value=="true") if String===value
    return unless value
    
    # passing nil to the file column causes the file to be deleted.  Don't delete if we just uploaded a file!
    self.report_file = nil unless self.report_file_just_uploaded?
  end

  # methods for recent activity module
  def activity_client
    household.to_label
  end

  def activity_item
    "Report"
  end

  def activity_date
    created_at
  end

  def activity_status
    if campaign.nil?
      "Ad Hoc"
    else
      "Campaign: " + campaign.name
    end
  end

  def activity_link_options
    {:controller=>"/portfolio/reports", :action=>"view", :id=>id}
  end
  
end
