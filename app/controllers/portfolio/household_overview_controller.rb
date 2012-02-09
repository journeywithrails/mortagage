class Portfolio::HouseholdOverviewController < PortfolioController
  require 'ym4r'
  include Ym4r::GoogleMaps
  require 'location'
  include ActionView::Helpers::NumberHelper

  before_filter :load_household, :except => [:index]
  before_filter :store_household, :only => [:show, :property_dashboard]

  # TODO - change these to be dark gray first, then lighter gray, etc.
  @@chart_colors ||= ["#DDD9C3", "#C4BD97", "#948A54", "#89804e", "#89804e"]

  # note: use @household.base_case_refi_scenario instead of @base_case_refi_scenario

  def index
    redirect_to :controller => 'portfolio/demographics'
  end

  def show
    session[:property_id] =nil
    load_campaigns
    load_inactive_loans
    
    #If there is a refi scenario then lets load the associated property
    if @household.refinance_refi_scenario
      # This method will find the property which is being refinanced (because the household may have more than one property)
      @best_refinance_scenario_property = \
        @household.refinance_refi_scenario.refi_properties.first(:conditions => ['keep_original_loans = 0'])
    end  
  end

  def create_note
    if !params[:household_note][:note].blank?
      @household.household_notes <<  HouseholdNote.new(params[:household_note])
    end

    # TODO - this should go away when we put this into the scaffold 
    @notes = @household.household_notes
    render :partial => 'notes'
  end

  def property_dashboard
    session[:property_id] =nil
    load_campaigns
    load_inactive_loans
    load_refi_properties

    # note: all we should need for the chart data is all the household's properties:
    # @household.properties

    build_current_loan_balance_chart_data
    build_current_pmt_chart_data
    build_monthly_savings_5year_arm_chart_data
    build_monthly_savings_30year_fixed_chart_data
    build_current_interest_rate_chart_data
    build_remaining_term_chart_data
    build_purchase_price_chart_data
    build_zillow_value_chart_data
    build_dashboard_equity_estimate_chart_data
  end  

  def property_detail
    session[:property_id] = params[:property_id]
    @property = @household.properties.find_by_id(params[:property_id])

    address = Geocoding::get(@property.property_address)

    if address.status == Geocoding::GEO_SUCCESS
      @map = GMap.new("map_div")
      @map.control_init(:large_map => true,:map_type => true)         
      @map.set_map_type_init(GMapType::G_SATELLITE_MAP)
      @map.center_zoom_init(address[0].latlon,18)      
      @map.overlay_init(GMarker.new(address[0].latlon))
    else
      @no_map = 'A map could not be generated for this address.'
    end

    # note: we are not using URLs for charts any more - we can put set the chart data inline (see build_equity_estimate_chart_data)
    #~ @loan_refinance_opportunity_charts_url = formatted_portfolio_home_details_url(:xml)

    # TODO - use property_valuation table - do not use zillow_cache
    # wait until we make needed changes to the pro1perty_valuation table before fixing
    # @property_valuation = PropertyValuation.find_first_by_property_id(@property_id)

    # TODO - delete and delete references in view
    @zillow_cache = ZillowCache.find(:first,
      :conditions =>"street_address  = '#{@property.address1}' AND city_state_zip = '#{@property.city_state_zip}'")

    @properties_for_sale = PropertyForSale.find_all_by_property_id(@property.id)

    load_base_case_refi_loans
    
    load_campaigns
    build_equity_estimate_chart_data
    build_loan_refinance_opportunity_chart_data

    load_loan_comparison_opportunities
  end

  
  private

  # refi_loan chart colors
  def chart_color(index)
    if (index > 4)
      @@chart_colors[4]
    else
      @@chart_colors[index - 1]
    end
  end
  
  def format_of_dollar_value(value)
    (number_to_currency(value, :precision=>0,:delimiter =>"")).split('$')[1]
  end
  
  def store_household
    session[:household_id] = @household.id
  end

  def load_base_case_refi_loans
    # note - refi_loans are ordered by loan rank (1,2)
    @base_case_refi_loans ||= @household.base_case_refi_scenario.refi_property_for_property_id(@property.id).refi_loans
  end

  # for the campaigns module
  def load_campaigns
    @campaign_list ||= current_broker_user.campaigns.find(:all,
      :conditions =>" execute_at > (curdate() + INTERVAL - 60 DAY)",
      :order => "execute_at asc",
      :limit => 10)
  end

  # for the loan history module
  def load_inactive_loans
    #We don't have to load any active loans since they can be reached through the Base Case refi scenario

    @inactive_loans = Loan.find(:all,
      :joins => "inner join property on loan.property_id = property.id " +
        "inner join household on property.household_id = household.id",
      :conditions => "household.id = #{@household.id} and is_active = 0")
  end

  def load_loan_comparison_opportunities
    # TODO - delete if not used
  end

  def load_household
    if params[:id]
      begin
        @household = current_broker_user.households.find(params[:id]) 
        @related_loans = []
        @related_loans = @household.head_of_hh_person.loans_as_co_borrower_person.all(:conditions => {:user_id => current_broker_user.id}) if @household && @household.head_of_hh_person && @household.head_of_hh_person.loans_as_co_borrower_person
        @person_financial = @household.head_of_hh_person.latest_person_financial
      rescue ActiveRecord::RecordNotFound
        redirect_to :action => :index
      end
    end
  end

  def load_refi_properties
    @refi_properties ||= @household.base_case_refi_scenario.refi_properties
  end
  
  def build_loan_refinance_opportunity_chart_data
    chart = Ambling::Data::ColumnChart.new
    
    chart.series << Ambling::Data::Value.new(@base_case_refi_loans.count > 1 ? "Original Loans" : "Original Loan", :xid => 1)
    chart.series << Ambling::Data::Value.new("New 30 Year Fixed Loan", :xid => 2)

    chart.graphs << original_loan_graph =  Ambling::Data::ColumnGraph.new([], :title => "Loan Payment", :color => "#C4BD97")
    chart.graphs << monthly_savings_graph = Ambling::Data::ColumnGraph.new([], :title => "Monthly Savings", :color => "#EEECE1")

    monthly_payment = 0

    @base_case_refi_loans.each do |refi_loan|
      if refi_loan.loan_rank > 1
        original_loan_graph << Ambling::Data::Value.new(format_of_dollar_value(refi_loan.monthly_payment), :xid => 1 , :color => "#948A54")
      else
        original_loan_graph << Ambling::Data::Value.new(format_of_dollar_value(refi_loan.monthly_payment), :xid => 1)
      end
      monthly_payment += refi_loan.monthly_payment
    end

    # note: always compare to 30 year fixed
    savings = @property.monthly_savings_for_new_loan_product(NewLoanProduct::ThirtyYearFixed)

    if savings then
      monthly_savings_graph << Ambling::Data::Value.new(format_of_dollar_value(monthly_payment - savings), :xid => 2)

      if savings > 0 then
        monthly_savings_graph << Ambling::Data::Value.new(format_of_dollar_value(savings), :xid => 2, :color =>"#EEECE1")
      else
        monthly_savings_graph << Ambling::Data::Value.new(format_of_dollar_value(savings), :xid => 2, :color =>"#ff0000")
      end
    end if savings

    @loan_refinance_opportunity_chart_data = chart.to_xml    
  end

  # in property detail page
  def build_equity_estimate_chart_data
    loan_amount = @household.base_case_refi_scenario.refi_property_for_property_id(@property.id).total_loan_amount
    appraisal_value = @property.appraisal_value

    if @property.zillow_value then
      equity_amount = @property.zillow_value - loan_amount
    else
      equity_amount = 0
    end

    chart = Ambling::Data::ColumnChart.new

    chart.series << Ambling::Data::Value.new("Based on Last Transaction", :xid => 0)
    chart.series << Ambling::Data::Value.new("Based on Zillow Estimate", :xid => 1)

    chart.graphs << loan_balance_graph =  Ambling::Data::ColumnGraph.new([], :title => "Loan Balance", :color =>"#C4BD97")
    chart.graphs << equity_graph = Ambling::Data::ColumnGraph.new([], :title => "Equity", :color => "#EEECE1")    
   
    loan_balance_graph << Ambling::Data::Value.new(format_of_dollar_value(loan_amount), :xid => 0,:gid=>1)
    equity_graph << Ambling::Data::Value.new(format_of_dollar_value(appraisal_value - loan_amount), :xid => 0, :color =>"#EEECE1",:gid=>0)

    if (equity_amount >= 0)
      loan_balance_graph << Ambling::Data::Value.new(format_of_dollar_value(loan_amount), :xid => 1,:color =>"#C4BD97",:gid=>0)
      equity_graph << Ambling::Data::Value.new(format_of_dollar_value(equity_amount), :xid => 1, :color =>"#EEECE1",:gid=>1)
    else
      equity_graph << Ambling::Data::Value.new(format_of_dollar_value(loan_amount), :xid => 1, :color =>"#C4BD97",:gid=>1)
      loan_balance_graph << Ambling::Data::Value.new(format_of_dollar_value(equity_amount), :xid => 1,:color =>"#EEECE1",:gid=>0)
    end
    
    @estimated_equity_chart_data = chart.to_xml
  end

  def build_current_loan_balance_chart_data
    chart = Ambling::Data::ColumnChart.new       
    chart.graphs << graph = Ambling::Data::ColumnGraph.new([], :color => "#f6ca55")
    
    index = 0

    @refi_properties.each do |refi_property|
      refi_property.refi_loans.each do |refi_loan|
        index += 1
        chart.series << Ambling::Data::Value.new(refi_property.property.address1 + refi_loan.loan_rank_label, :xid => index)        
        graph << Ambling::Data::Value.new(format_of_dollar_value(refi_loan.loan_amount), :xid => index, :color => chart_color(index))
      end
    end
    
    @loan_balance = chart.to_xml   
  end

  #"#{number_to_currency(record.best_refi_scenario.total_loan_value, :precision=>0)}"
  def build_current_pmt_chart_data
    chart = Ambling::Data::ColumnChart.new
    chart.graphs << graph = Ambling::Data::ColumnGraph.new([], :color => "#f6ca55")

    index = 0

    @refi_properties.each do |refi_property|
      refi_property.refi_loans.each do |refi_loan|
        index += 1
        chart.series << Ambling::Data::Value.new(refi_property.property.address1 + refi_loan.loan_rank_label, :xid => index)
        graph << Ambling::Data::Value.new(format_of_dollar_value(refi_loan.monthly_payment),:xid => index, :color => chart_color(index))
      end
    end

    @current_pmt_data = chart.to_xml   
  end

  def build_monthly_savings_5year_arm_chart_data
    properties = @household.properties

    chart = Ambling::Data::ColumnChart.new
    chart.graphs << purchase_price_chart_graph = Ambling::Data::ColumnGraph.new([],:color => "#948A54")

    properties.each_with_index do |property, index|
      index += 1
      chart.series << Ambling::Data::Value.new(property.address1, :xid => index)
      purchase_price_chart_graph << Ambling::Data::Value.new(property.monthly_savings_for_new_loan_product(NewLoanProduct::FiveYearARM),
        :xid => index, :color=>chart_color(index))
    end

    @monthly_savings_5years_data = chart.to_xml
  end

  def build_monthly_savings_30year_fixed_chart_data
    properties = @household.properties

    chart = Ambling::Data::ColumnChart.new
    chart.graphs << purchase_price_chart_graph = Ambling::Data::ColumnGraph.new([],:color => "#948A54")

    properties.each_with_index do |property, index|
      index += 1
      chart.series << Ambling::Data::Value.new(property.address1, :xid => index)
      purchase_price_chart_graph << Ambling::Data::Value.new(property.monthly_savings_for_new_loan_product(NewLoanProduct::ThirtyYearFixed), 
        :xid => index,:color => chart_color(index))
    end

    @monthly_savings_30years_data = chart.to_xml
  end

  def build_current_interest_rate_chart_data
    chart = Ambling::Data::ColumnChart.new
    chart.graphs << graph = Ambling::Data::ColumnGraph.new([], :color => "#f6ca55")

    index = 0

    @refi_properties.each do |refi_property|
      refi_property.refi_loans.each do |refi_loan|
        index += 1
        chart.series << Ambling::Data::Value.new(refi_property.property.address1 + refi_loan.loan_rank_label, :xid => index)
        graph << Ambling::Data::Value.new(refi_loan.note_rate, :xid => index, :color => chart_color(index))
      end
    end

    @current_interest_data = chart.to_xml     
  end

  def build_remaining_term_chart_data
    chart = Ambling::Data::ColumnChart.new
    chart.graphs << graph = Ambling::Data::ColumnGraph.new([], :color => "#f6ca55")

    index = 0

    @refi_properties.each do |refi_property|
      refi_property.refi_loans.each do |refi_loan|
        index += 1
        chart.series << Ambling::Data::Value.new(refi_property.property.address1 + refi_loan.loan_rank_label, :xid => index)
        graph << Ambling::Data::Value.new(refi_loan.loan_term, :xid => index, :color => chart_color(index))
      end
    end

    @remaining_term_data = chart.to_xml     
  end

  def build_purchase_price_chart_data
    properties = @household.properties
    
    chart = Ambling::Data::ColumnChart.new       
    chart.graphs << graph = Ambling::Data::ColumnGraph.new([], :color => "#f6ca55")
    
    properties.each_with_index do |property, index|
      index += 1
      chart.series << Ambling::Data::Value.new(property.address1, :xid => index)
      graph << Ambling::Data::Value.new(format_of_dollar_value(property.purchase_price), :xid => index, :color => chart_color(index))
    end
    
    @purchase_price_data = chart.to_xml    
  end

  def build_zillow_value_chart_data
    chart = Ambling::Data::ColumnChart.new
    chart.graphs << zillow_graph = Ambling::Data::ColumnGraph.new([], :title => "Zillow",:color => "#948A54")
    chart.graphs << appraisal_graph = Ambling::Data::ColumnGraph.new([], :title => "Appraisal",:color =>  "#d9d9e9")  #TODO - fix color

    @refi_properties.each_with_index do |refi_property, index|
      index += 1
      chart.series << Ambling::Data::Value.new(refi_property.property.address1, :xid => index)

      if refi_property.property_valuation.valuation_type_id == ValuationType::Zillow then
        zillow_graph << Ambling::Data::Value.new(format_of_dollar_value(refi_property.current_valuation), :xid => index, :color => chart_color(index))
        appraisal_graph << Ambling::Data::Value.new(0, :xid => index)
      else
        appraisal_graph << Ambling::Data::Value.new(format_of_dollar_value(refi_property.current_valuation), :xid => index, :color =>  "#d9d9e9")
        zillow_graph << Ambling::Data::Value.new(0, :xid => index, :color => chart_color(index))
      end
    end

    @zillowvalue_data = chart.to_xml  
  end

  def build_dashboard_equity_estimate_chart_data
    chart = Ambling::Data::ColumnChart.new
    
    chart.graphs << equity_graph = Ambling::Data::ColumnGraph.new([], :title => "Equity", :color => "#948A54")   

    @refi_properties.each_with_index do |refi_property, index|
      index += 1
      chart.series << Ambling::Data::Value.new(refi_property.property.address1, :xid => index)
      loan_amount = refi_property.total_loan_amount
      zillow_value = refi_property.current_valuation      
      equity_graph << Ambling::Data::Value.new(format_of_dollar_value(zillow_value - loan_amount), :xid => index, :color=>  chart_color(index)) if zillow_value
    end
    
    @equity_data = chart.to_xml   
  end

end
