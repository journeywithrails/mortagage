xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.chart do
  
  xml.series do    
    @top_zip_codes.each_with_index do |household, index|
	 value = household.zip
      xml.value value, :xid => index	  
    end
  end
  
  
  xml.graphs do
    xml.graph :color => "#0000CC",:gid => 1, :fill_color => "#0000CC"  do
      @top_zip_codes.each_with_index do |household, index|
        value = household.no_of_borrowers
        xml.value value, :xid => index, :color => "#F4B50E"   
        
      end
    end 
  end
  
end