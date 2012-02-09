module Opportunity::CollegeHelper
  
  def college_mae_index_column(record)
    link_to_college_planning_detail(record, :text=>record.college_mae_index)
  end

  def number_of_dependents_column(record)
    link_to_college_planning_detail(record, :text=>record.number_of_dependents)
  end
  
  def address_column(record)
    link_to_college_planning_detail(record, :text=>record.head_of_hh_person.address1, :color=> "#f1b200")
  end

  def city_column(record)
    link_to_college_planning_detail(record, :text=>record.head_of_hh_person.city, :color=>"#625D45")
  end

  def loan_amount_column(record)
    link_to_college_planning_detail(record, :text=>"#{number_to_currency(record.best_refi_scenario.total_loan_value, :precision=>0)}") unless record.best_refi_scenario.nil?
  end

  def head_of_hh_person_column(record)
    link_to_college_planning_detail(record, :text=>record.head_of_hh_person.to_label)
  end

  private
   
  def link_to_college_planning_detail(record, options={})
    options.merge! :opportunity_type_id=>OpportunityType::CollegePlanning
    
    link_to_opportunity_detail(record, options)
  end
  
end
