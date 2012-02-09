class Opportunity::CollegeController < OpportunityController

  active_scaffold :household do |config|
    config.actions = [:list]

    # most of these columns come from helpers/opportunity/all_helper.rb
    config.columns = [:college_mae_index, :head_of_hh_person, :address, :city, :number_of_dependents, :loan_amount]

    columns[:head_of_hh_person].label = "Name"
    columns[:college_mae_index].label = "MAE Index"
    columns[:number_of_dependents].label = "# of Dependents"
    columns[:loan_amount].label = "Funding Needed"
    columns[:college_mae_index].css_class ="text_center_align"
    list.per_page = 15
    list.sorting = {:college_mae_index => :desc}
  end

  def conditions_for_collection
    ['college_mae_index > ? and user_id = ?', 70, current_broker_user.id]
  end
  
  def college_planning_requirements
  end
  
  def loan_option2
  end
  
  def loan_comparison
  end
  
  def hh_summary
  end

end
