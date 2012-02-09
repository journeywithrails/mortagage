module Opportunity::ReportsHelper
  def report_file_column(record)
    link_to_report_file(record,'view report')
  end

  def household_column(record)
    link_to_opportunity_detail(record.household, :opportunity_type_id=>record.opportunity_type_id)
  end

  private 

  def link_to_report_file(record, text_value)
    link_to(h(text_value), {:controller=>'/reports', :action=>'view',:id=>record.id})
  end
end
