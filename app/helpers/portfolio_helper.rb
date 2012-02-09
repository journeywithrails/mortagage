require 'client_news'

module PortfolioHelper
  
  def news_search(household)
       news_list =  '<script type="text/javascript"> function doSearch()
      { searcher = new google.search.NewsSearch();
        searcher.setSearchCompleteCallback(null,processSearchResults);'      
       news_list <<  ClientNews.related_news(household, true)
       news_list << ' }</script>'     
  end  




    
  private
  
  def household_overview_link(record, text_value)
    # removed: , :style => "color:#948b54" - don't put style information here
    link_to(h(text_value), portfolio_household_overview_path(record))
  end
   
end
