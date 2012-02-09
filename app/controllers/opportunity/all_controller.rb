class Opportunity::AllController < OpportunityController

  # note: common helpers are in the opportunity_helper
 
  active_scaffold :household  do |config|
    config.actions = [:list]

    # most of these columns come from helpers/opportunity/all_helper.rb
    config.columns = [:best_mae_index, :head_of_hh_person, :address, :city, :type, :loan_amount]

    columns[:head_of_hh_person].label = " Name"
    columns[:best_mae_index].label = "MAE Index    "
    columns[:loan_amount].label = "Loan Size"

    columns[:city].sort_by :sql => "person.city"
    columns[:type].sort_by :sql => "opportunity_type.name"

    columns[:best_mae_index].css_class ="text_center_align"
    
    # TODO - smarter detection of whether the job processing is running on the user's data
    config.list.no_entries_message = "You do not have any opportunities with a MAE Index over 70. We are probably still uploading or scoring your borrower files."

    list.per_page = 15
    list.sorting = {:best_mae_index => :desc}
  end

  def conditions_for_collection
    ['best_mae_index > ? and user_id = ?', 70, current_broker_user.id]
  end

  def joins_for_collection
    "best_opportunity_type"
  end

  def show
    # randomly select 5 of the top 50 opportunities - much faster than using rand()
    @households_for_news_search = current_broker_user.households.find(:all, 
      :conditions => ["best_mae_index > 70"],
      :limit => 5,
      :offset=>(50*rand).to_i)
    
    @properties_for_sale = current_broker_user.properties_for_sale(:limit=>5)

    portfolio_watch  
    upcoming_events
    recent_activities
    # counter for ajax refresh for upcoming events
    $counter  = 0
    
  end

  def portfolio_watch
  end

  def upcoming_events
    @household_events = HouseholdEvent.find(:all,
      :conditions=> "household_event.account_id = #{current_account.id} and household.best_mae_index > 60 and date >= Date(Now()) and is_dismissed = 0",
      :joins => "inner join household on household_id = household.id",
      :order => "date",
      :limit => 20)      
  end

  def dismiss_event
    @household_event = HouseholdEvent.find_by_id(params[:id])
    @household_event.update_attributes(:is_dismissed => 1)
    # incrementing counter for ajax refresh for upcoming events when the user dismisses more than 5 items
    $counter  = $counter+1 
    
      if $counter == 5
        upcoming_events
          render :update do |page|      
            page.replace_html 'upcoming_events', :partial => 'upcoming_events',:locals =>{:household_events => @household_events}
          end
      else
          render :update do |page|      
            page.replace_html "upcoming_events#{params[:i]}"
          end      
      end
       
  end   

  
  def recent_activities
    @recent_activities = []

    @recent_activities += current_broker_user.recent_proposals(:limit=>10) +
                          current_broker_user.recent_adhoc_reports(:limit=>10) +
                          current_broker_user.recent_campaign_reports(:limit=>10)

    @recent_activities.sort_by {|a| a.activity_date}
    @recent_activities.reverse!

    # keep the list to a max of 20
    while @recent_activities.length > 20 do
      @recent_activities.pop
    end

    # the above models have the following common methods:
    #   activity_date, activity_status, activity_item, activity_client
    # see: https://mobilefoundry.grouphub.com/projects/2753511/todo_items/32511900/comments
  end

end
