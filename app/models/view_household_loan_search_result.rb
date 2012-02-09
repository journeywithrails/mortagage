class ViewHouseholdLoanSearchResult < ActiveRecord::Base
  has_one :view_household_loan, :foreign_key => :id
  belongs_to :user, :class_name => 'BrokerUser', :foreign_key => :user_id
  
  serialize :names
  serialize :addresses

  # Params is a hash as it comes from the HouseholdSearch pages
  def names_matching_search(params)
    search_array_for_names_keywords(params, self.names)
  end
  
  # Params is a hash as it comes from the HouseholdSearch pages
  def addresses_matching_search(params)
    if basic_search?(params)
      search_array_for_names_keywords(params, self.addresses)
    else
      advanced_search_array_for_keywords(params, self.addresses)
    end
  end

  def search_array_for_names_keywords(params, array)
    return '' unless array
    begin
      keywords = params[:search][:conditions][:group][:names_keywords].split.map {|keyword| Regexp.new(Regexp.escape(keyword), Regexp::IGNORECASE) }
      expression = build_expression(keywords)
      results = array.grep(expression) if expression
      return results.first if results && results.length > 0
    rescue NoMethodError => ex
    end
    array.first
  end

  def advanced_search_array_for_keywords(params, array)
    return '' unless array
    begin
      keywords = params[:search][:conditions][:city_keywords].split.map {|keyword| Regexp.new(Regexp.escape(keyword), Regexp::IGNORECASE) }
      keywords += params[:search][:conditions][:street_name_keywords].split.map {|keyword| Regexp.new(Regexp.escape(keyword), Regexp::IGNORECASE) }
      expression = build_expression(keywords)
      results =  array.grep(expression) if expression
      return results.first if results && results.length > 0
    rescue NoMethodError => ex
    end
    array.first
  end

  private
  def build_expression(keywords)
    expression = keywords.pop
    keywords.each_cons(1) { |keyword| expression = Regexp::union(expression, keyword.first) }
    expression
  end

  def basic_search?(params)
    params[:search] && params[:search][:conditions] && params[:search][:conditions][:group] && params[:search][:conditions][:group][:names_keywords]
  end
end
