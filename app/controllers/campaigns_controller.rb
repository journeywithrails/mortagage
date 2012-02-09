class CampaignsController < ApplicationController
  def initialize
    super
    self.subtab_nav = "campaigns"
  end
  
  active_scaffold :campaign do |config|
    config.actions = [:list] # , :update, :create
    config.columns = [:name, :campaign_channel, :execute_at,  :created_at]
#    config.create.columns.exclude :created_at
#    config.update.columns.exclude :created_at

    config.columns[:campaign_channel].form_ui = :select   
    config.columns[:execute_at].form_ui = :calendar_date_select

    config.columns[:created_at].label = "Date Created"
    config.columns[:execute_at].label = "Execute Date"
    config.columns[:campaign_channel].label = "Channel"

    config.list.no_entries_message = "You have not created any campaigns. To create your first campaign, click on the \"create new\" link in the header above."

    list.sorting = {:created_at => :desc}
    #    list.per_page = 40
  end
  
  def show
    list
  end
    
  def before_create_save(record)
    record.user_id = current_broker_user.id
  end
  
  def conditions_for_collection
    ['user_id = ?', current_broker_user.id]
  end
  
end
