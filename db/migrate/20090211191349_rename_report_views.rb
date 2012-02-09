class RenameReportViews < ActiveRecord::Migration
  def self.up
    execute "rename table propertyreport to view_property_report" 
    execute "rename table propertyreportimage to view_property_report_image" 
    execute "rename table top_zip_codes to view_top_zip_codes" 
    exeucte "rename table transactions_trends to view_transactions_trends" 
  end

  def self.down
    execute "rename table view_property_report to propertyreport " 
    execute "rename table view_property_report_image to propertyreportimage " 
    execute "rename table view_top_zip_codes to top_zip_codes" 
    exeucte "rename table view_transactions_trends to transactions_trends"  
  end
end
