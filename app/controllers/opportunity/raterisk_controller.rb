class Opportunity::RateriskController < OpportunityController
  
  active_scaffold :household  do |config|
    config.actions = [:list]

    # most of these columns come from helpers/opportunity/all_helper.rb
    config.columns = [:best_mae_index, :head_of_hh_person, :address, :city, :loan_amount]

    columns[:head_of_hh_person].label = "head of household"
    columns[:best_mae_index].label = "MAE Index"
    columns[:best_mae_index].css_class ="text_center_align"
    list.per_page = 15
    list.sorting = {:best_mae_index => :desc}
  end

  def conditions_for_collection
    ['best_mae_index > ? and user_id = ?', 70, current_broker_user.id]
  end
  
  
  def rate_risk_opportunity
  end
  
  def hh_summary
  end
  
end
