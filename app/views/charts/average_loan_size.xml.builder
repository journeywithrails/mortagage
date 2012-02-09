xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.chart do
  
  xml.series do    
    @average_loan_size.each_with_index do |household, index|
	 value = household.period
      xml.value value, :xid => index
	  
	  
    end
  end
  
  xml.graphs do
    xml.graph :title => 'Transactions Per Month', :gid => 1,:color => "#0000CC", :fill_color => "#0000CC" do
      @average_loan_size.each_with_index do |household, index|
        value = household.average_loan_amount
        xml.value value, :xid => index, :color => "#F4B50E"
        
	   end
    end 
  end
  
end