class AddRefinanceReportGlobalProperties < ActiveRecord::Migration
  def self.up
    uploadsDir = GlobalProperty.find_by_name('UserFilesRoot')
    uploadsDir.property_value = '/home/admin/deploy/mortgagescience/shared/uploads'
    uploadsDir.save

    jrxmlDir = GlobalProperty.new
    jrxmlDir.property_value = '/home/admin/deploy/mortgagescience/shared/jrxml'
    jrxmlDir.name = 'JrxmlFilesRoot'
    jrxmlDir.save
  end

  def self.down
    BrokerModel.establish_connection("#{RAILS_ENV}")
    uploadsDir = GlobalProperty.find_by_name('UserFilesRoot')
    uploadsDir.property_value = '/home/admin/public_html/mortgagescience/uploads/'
    uploadsDir.save

    jrxmlDir = GlobalProperty.find_by_name('JrxmlFilesRoot')
    jrxmlDir.destroy
  end
end
