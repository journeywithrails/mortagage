class ClientNews
   
  def self.related_news(household, include_first_property = false)
    search_phrase = ''

    household.people.each do |person|
      if !person.first_name.blank? && !person.last_name.blank? && !person.city.blank?
        search_phrase << borrower_co_borrower_name_search_phrase(person)
      end
    end
    
    if !household.head_of_hh_person.latest_person_financial.employer_name.blank?
      search_phrase << borrower_employer_name_search_phrase(household.head_of_hh_person.latest_person_financial.employer_name)
    end

    if include_first_property
      property = household.properties.first

      if !property.city.blank?
        search_phrase << property_city_name_search_phrase(property)
      
        if !property.address1.blank?
          search_phrase << property_street_name_search_phrase(property)
        end
      end
    end

    return search_phrase
  end
   
  def self.borrower_co_borrower_name_search_phrase(person)
    'searcher.execute(" \"'+person.first_name+' '+person.last_name+'\" [(birth OR engagement OR obituary OR award OR promoted OR promotion) AND \"'+person.city+'\" ]");'
  end
 
  def self.borrower_employer_name_search_phrase(employer_name)
    'searcher.execute("\"'+employer_name+'\"  [layoff OR \"plant closure\" OR merger OR divestiture OR \"profit warning\" OR restructuring OR \"corporate relocation \"]");'
  end
 
  def self.property_city_name_search_phrase(property)
    'searcher.execute("\"'+property.city+'\"  [zoning OR \"real estate\" OR \"home prices\" OR foreclosures OR \"city council\" OR \"home sales\"]");'
  end
 
  def self.property_street_name_search_phrase(property)
    'searcher.execute("\"'+property.address1+'\" [\"'+property.city+'\"]");'
  end
  
end