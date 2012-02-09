class Opportunity::ReportsController < OpportunityController
  REPORT_RUNNER_CLASS = "com.somispo.tasks.reporting.RunReport"
  PROCESS_TYPE_REPORTING = 4

  active_scaffold :household_report  do |config|
    config.actions = [:list]
    config.columns = [:household, :opportunity_type, :created_at, :report_file]

    columns[:report_file].sort = false
    list.sorting = {:created_at => :desc}
  end

  def conditions_for_collection
    ["household_report.user_id = ?", current_broker_user.id]
  end

  def download
    pdf = current_broker_user.household_reports.find(params[:id])[:report_file]
    send_pdf_file(pdf, true)
  end

  def view
    pdf = current_broker_user.household_reports.find(params[:id])[:report_file]
    send_pdf_file(pdf, false)
  end

  def refinance
    jrxmlFilesRoot = GlobalProperty.find_by_name('JrxmlFilesRoot').property_value
    # TODO: define temp location for file
    filename = 'refinance'
    # TODO: spec refinance jrxml and it's parameters
    campaignId=1
    refiScenarioId=2
    opportunityTypeId=1
    householdId = params[:household_id]
    xml_spec = "
      <runReport 
          class=\"#{REPORT_RUNNER_CLASS}\" 
          userId=\"#{current_user.id}\" 
          jrxml=\"#{jrxmlFilesRoot}refi report 03032009.jrxml\" 
          householdId=\"#{householdId}\"
          #{campaignId ? "campaignId=\"#{campaignId}\"" : ""}
          #{refiScenarioId ? "refiScenarioId=\"#{refiScenarioId}\"" : ""}
          #{opportunityTypeId ? "opportunityTypeId=\"#{opportunityTypeId}\"" : ""}>
        <parameter name=\"title_page_main_image\">
          /mnt/somispo.root/home/admin/deploy/mortgagescience/shared/jrxml/sunnyt.png
        </parameter>
        <parameter name=\"broker_image\">
          #{current_user.photo_file}
        </parameter>
      </runReport>
    "

    @job = Job.new( :process_type_id => PROCESS_TYPE_REPORTING, 
                    :account_id => current_account.id, 
                    :user_id => current_user.id,
                    :server_id => current_server.id, 
                    :task_class_id =>3,
                    :job_specification => xml_spec)
    @job.save
    
    redirect_to :action => "index"
    # params: household_id
    # use current_user.id
    #
    # create report job - see FileUploadController for example of creating job
    # tell job processing framework to run report job
    # wait for job to finish - show dancing monkey
    # send_file(pdf_url)
  end

  private

  def send_pdf_file(pdf_filename, download)
    send_file( pdf_filename,
      :type => download ? 'application/x-pdf' : 'application/pdf',
      :disposition => 'inline',
      :filename =>  pdf_filename)
  end

end
