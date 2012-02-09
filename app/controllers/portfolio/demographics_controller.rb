class Portfolio::DemographicsController < PortfolioController
  
  HALF_YEAR = 180
  FULL_YEAR = 365
  LIFETIME = 100000

  def show
    #to disable the links "Property Dashboard", "Property Detail",  "Household Overview" for  _portfolio_tabnav tab
    session[:household_id]=nil
    session[:property_id] =nil
    
    @view_loan_portfolio = ViewLoanPortfolio.find(:first, :conditions => ["user_id = ?", current_user.id])
    @view_total_loan = ViewTotalLoan.find(:first, :conditions => ["user_id = ?", current_user.id])
    @view_new_client = ViewNewClient.find(:first, :conditions => ["user_id = ?", current_user.id])
    
    load_loan_types
    load_loan_purposes
    load_property_uses
               
    build_transactions_per_month_chart_data
    build_average_loan_size_chart_data
    build_top_zip_codes_chart_data
  end
    
  private

  def load_loan_types
    # Loan Origination Performance
    #
    # access these by days, e.g. @user_summary[HALF_YEAR]
    #
    # access the _by_loan_type methods with double keys, e.g.:
    #    @user_summary_by_loan_type[loan_type_name][HALF_YEAR]

    user_summary = ViewLoanOriginationPerformanceSummary.find(:all,
      :conditions => ["user_id = ?", current_broker_user.id])
    region_summary = ViewLoanOriginationPerformanceSummaryRegionalNetwork.find(:all,
      :conditions => ["mae_regional_network_id = ?", current_broker_user.mae_regional_network_id])

    @user_summary = group_by_days(user_summary)
    @user_commission = group_by_days(ViewLoanOriginationPerformanceCommission.find(:all,
        :conditions => ["user_id = ?", current_broker_user.id]))
    @region_summary = group_by_days(region_summary)
    @region_commission = group_by_days(ViewLoanOriginationPerformanceCommissionRegionalNetwork.find(:all,
        :conditions => ["mae_regional_network_id = ?", current_broker_user.mae_regional_network_id]))

    @user_summary_by_loan_type = group_by_days_and_name(user_summary)
    @region_summary_by_loan_type = group_by_days_and_name(region_summary)
  end

  def load_loan_purposes
    # TODO
  end

  def load_property_uses
    # Loan Origination Performance
    #
    # access these by days, e.g. @user_summary[HALF_YEAR]
    #
    # access the _by_days methods with double keys, e.g.:
    #    @user_property_use_by_days[name][HALF_YEAR]

    user_summary = ViewLoanOriginationPropertyUse.find(:all,
      :conditions => ["user_id = ?", current_broker_user.id])
    region_summary = ViewLoanOriginationPropertyUseRegionalNetwork.find(:all,
      :conditions => ["mae_regional_network_id = ?", current_broker_user.mae_regional_network_id])

    @user_property_use = group_by_days(user_summary)
    @region_property_use = group_by_days(region_summary)

    @user_property_use_by_days = group_by_days_and_name(user_summary)
    @region_property_use_by_days = group_by_days_and_name(region_summary)
  end

  def build_transactions_per_month_chart_data
    # note - the view sorts by date descending, & we want the most recent 10 records in chronological order, thus the .reverse
    @monthly_trend ||= ViewTransactionsTrend.find(:all, :limit => 24, :conditions => ["user_id = ?", current_broker_user.id]).reverse
    
    chart = Ambling::Data::ColumnChart.new       
    chart.graphs << transactions_graph = Ambling::Data::ColumnGraph.new([], :gid => 1, :title => "Transactions Per Month", :color => "#f6ca55")
    
    @monthly_trend.each_with_index do |household, index|
      chart.series << Ambling::Data::Value.new(household.period, :xid => index)
      transactions_graph << Ambling::Data::Value.new(household.closed_loan_count, :xid => index)
    end
    
    @transactions = chart.to_xml   
  end
  
  def build_average_loan_size_chart_data
    # note - the view sorts by date descending, & we want the most recent 10 records in chronological order, thus the .reverse
    @monthly_trend ||= ViewTransactionsTrend.find(:all, :limit => 24, :conditions => ["user_id = ?", current_broker_user.id]).reverse

    chart = Ambling::Data::ColumnChart.new       
    chart.graphs << loans_graph = Ambling::Data::ColumnGraph.new([], :gid => 1,  :title => "Average Loans" ,:color => "#f6ca55")
    
    @monthly_trend.each_with_index do |household, index|
      chart.series << Ambling::Data::Value.new(household.period, :xid => index)
      loans_graph << Ambling::Data::Value.new(household.average_loan_amount/1000, :xid => index)
    end

    @average_loans = chart.to_xml
  end
  
  def build_top_zip_codes_chart_data
    chart = Ambling::Data::ColumnChart.new       
    top_zip_codes = ViewTopZipCode.find(:all, :limit=>5, :conditions => ["user_id = ?", current_broker_user.id])
    
    chart.graphs << zip_codes_graph = Ambling::Data::ColumnGraph.new([], :gid => 1,  :title => "Zip Codes" ,:color => "#f6ca55")
    
    top_zip_codes.each_with_index do |household, index|
      chart.series << Ambling::Data::Value.new(household.zip, :xid => index)
      zip_codes_graph << Ambling::Data::Value.new(household.no_of_borrowers, :xid => index)
    end

    @zip_codes = chart.to_xml
  end
    
  # hash of items by the days method. sums using add_values for multi loan type arrays
  def group_by_days(array)
    group = Hash.new

    array.each do |item|
      key = item.days
      if group[key].nil? then
        group[key] = item.clone
      else
        #        logger.debug "group[key] = " + group[key].to_s
        #        logger.debug "item = "+ item.to_s
        group[key].add_values(item)
      end
    end
    
    group
  end

  # 2-d hash of items by loan type name and days
  def group_by_days_and_name(array)
    group = Hash.new

    array.each do |item|
      #      logger.debug "loan_type_item = "+ item.name
      #      logger.debug "item count = " + item.count.to_s
      group[item.name] = Hash.new if group[item.name].nil?
      group[item.name][item.days] = item.clone
    end
    
    group
  end
   
end
