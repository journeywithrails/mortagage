class Portfolio::ViewHouseholdLoanController < PortfolioController
  protect_from_forgery :only => [:create, :update, :destroy]
  before_filter :create_user_search, :only => [:index, :advanced_search, :do_search]
  helper_method :get_search

  def index
    session[:household_id]=nil
    build_conditions
  end
  
  def advanced_search
    build_conditions

    @housing_types ||= HousingType.find(:all)
    @property_uses ||= PropertyUse.find(:all)
    @loan_types ||= LoanType.find(:all)
  end

  def search_files_to_review

  end

  def incomplete_files

  end

  def do_search
    @result = ''

    unless params[:search][:conditions][:group][:names_keywords].blank?
      @search.conditions.group do |group|
        group.or_borrower_name_like = params[:search][:conditions][:group][:names_keywords]
        group.or_co_borrower_name_like = params[:search][:conditions][:group][:names_keywords]
        group.or_street_name_like = params[:search][:conditions][:group][:names_keywords]
        group.or_city_like = params[:search][:conditions][:group][:names_keywords]
      end
    end
    
    build_conditions

    render :update do |page|
      page.visual_effect :highlight,  "search_results"
      page.replace_html 'search_results', :partial => 'search_results'
    end
  end
  
  def do_advanced_search
    @search = ViewHouseholdLoan.new_search(params[:search])
    @search.conditions.user_id = current_broker_user.id
      
    build_conditions
    
    render :update do |page|
      page.visual_effect :highlight,  'search_results'
      page.replace_html 'search_results', :partial => 'search_results'
    end
  end
  
  protected
  def get_search
    @search
  end
  
  private
  
  def create_user_search
    @search = ViewHouseholdLoan.new_search()
    @search.conditions.user_id = current_broker_user.id
  end
  
  def build_conditions
    @conditions = @search.sanitize[:conditions]
  end
    
end
