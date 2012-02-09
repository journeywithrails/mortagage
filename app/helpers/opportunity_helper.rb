require 'client_news'


module OpportunityHelper

  def client_related_news(households)
     news_list = 
        '<script type="text/javascript"> function doSearch()
        {
        searcher = new google.search.NewsSearch();
        searcher.setSearchCompleteCallback(null,processSearchResults);'      
       households.each do |household|
         news_list <<  ClientNews.related_news(household, false)
       end
      news_list << ' }</script>'
  end

  def last_campaign_sent_label
    if current_broker_user.latest_campaign.blank?
      "No campaigns have been sent."
    else
      "Your last campaign was sent on <span>" + current_broker_user.latest_campaign.execute_at.strftime("%B %d, %Y") + "</span>"
    end
  end

  def last_synchronized_label
    if current_broker_user.latest_upload.blank?
      "No uploads found."
    else
      "Your data was last synchronized on <span>" + current_broker_user.latest_upload.upload_date_time.strftime("%B %d, %Y") + "</span>"
    end
  end

  private
    
  # note: re-write of opp_detail_link
  # links to the detail page of the opportunity for the household.
  # options :opportunity_type_id=>123 defaults to household.best_opportunity_type_id
  #         :text=>"something" defaults to household label
  #         :color=>"#123456" defaults to #000000
  def link_to_opportunity_detail(household, options = {})
    # TODO - move this to application helper?
    
    options.reverse_merge! :opportunity_type_id=>household.best_opportunity_type_id,
                           :text=>household.to_label
    
    if options[:color]
      options.merge! :style=>"color: " + options[:color]
    end
    
    case options[:opportunity_type_id]
      when OpportunityType::Refinance
        controller = "/opportunity/refinance"
        action = "property_information"
      when OpportunityType::DebtConsolidation
        controller = "/opportunity/debt"
        action = "debt_consolidation_details"
      when OpportunityType::CollegePlanning
        controller = "/opportunity/college"
        action = "college_planning_requirements"
      when OpportunityType::Retirement
        controller = "/opportunity/retire"
        action = "retirement_information"
      when OpportunityType::ARMWatch
        controller = "/opportunity/raterisk"
        action = "rate_risk_opportunity"
      else
        controller = "/opportunity/all"
        action = "index"
    end
    
    link_to(h(options[:text]),{ :controller=>controller, :action=>action, :id=>household.id }, options)    
  end

end
