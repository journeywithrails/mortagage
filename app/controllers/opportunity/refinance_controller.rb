class Opportunity::RefinanceController < OpportunityController

  before_filter :setup_search, :only => [:show, :search]

  active_scaffold :household  do |config|
    config.actions = [:list]
    
    # most of these columns come from helpers/opportunity/all_helper.rb
    config.columns = [:refinance_mae_index, :head_of_hh_person, :address, :city, :loan_amount, :monthly_savings]
    
    columns[:head_of_hh_person].label = "Name "
    columns[:refinance_mae_index].label = "MAE Index "

    columns[:refinance_mae_index].css_class ="text_center_align"
    
    list.per_page = 20
    list.sorting = {:refinance_mae_index => :desc}
  end

  # this tells active scaffold the conditions for the list
  # using @conditions allows us to dynamically build this
  def conditions_for_collection
    @conditions
  end

  def show
    build_search_conditions
  end

  def search          
    if  !params[:search][:conditions][:head_of_hh_person][:first_name_keywords].blank?
      @search.conditions.group do |group|
        group.head_of_hh_person.first_name_like = params[:search][:conditions][:head_of_hh_person][:first_name_keywords]
        group.head_of_hh_person.or_last_name_like = params[:search][:conditions][:head_of_hh_person][:first_name_keywords]
        group.head_of_hh_person.or_address1_like = params[:search][:conditions][:head_of_hh_person][:first_name_keywords]
        group.head_of_hh_person.or_city_like = params[:search][:conditions][:head_of_hh_person][:first_name_keywords]
      end
    end
    
    build_search_conditions

    # ajax replace active scaffold container
    render :update do |page|
      page.visual_effect :highlight, 'search_results'
      page.replace_html 'search_results',
        render(:active_scaffold => '/opportunity/refinance', :label => 'Refinance Opportunities', :conditions => @conditions)
    end
  end

  def property_information
    load_campaigns
    @property = Property.find_by_household_id(params[:id])
    @household = current_broker_user.households.find(params[:id])
    
    # TODO - this is wrong 
    @zillow_cache = ZillowCache.find(:first,:select =>"tax_assessment , lot_size_sq_ft,use_code,year_built,zestimate_in_cents,latitude,longitude",
      :conditions =>"street_address  = '#{@property.address1}' AND city_state_zip = '#{@property.city_state_zip}'")
  end
    
  def property_information2
    
  end
    
  def property_information3
  end

  private

  def setup_search
    @search = Household.new_search()
    @search.conditions.user_id = current_broker_user.id
    @search.conditions.refinance_mae_index_gt = 70
  end
  
  def build_search_conditions
    @conditions = @search.sanitize[:conditions]
  end
  
  def load_campaigns
    @campaign_list ||= current_broker_user.campaigns.find(:all,:conditions =>" execute_at > (curdate( ) + INTERVAL - 60 DAY)",:order => "execute_at desc",:limit => 10)
  end
end
