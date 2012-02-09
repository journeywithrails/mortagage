xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.chart do
  
  xml.series do    
    @transactions_per_month.each_with_index do |household, index|
	 value = household.period
      xml.value value, :xid => index
	  
	  
    end
  end
  
  xml.graphs do
    xml.graph  :gid => 1,:color => "#0000CC", :fill_color => "#0000CC" do
      @transactions_per_month.each_with_index do |household, index|
        value = household.closed_loan_count
        xml.value value, :xid => index, :color => "#F4B50E"
        
        
      end
    end 
  end
  
end