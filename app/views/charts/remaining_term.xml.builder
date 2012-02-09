xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.chart do
  
  xml.series do    
    @remaining_term.each_with_index do |loan, index|
	      xml.value loan.address1, :xid => index  
    end
  end
  
  xml.graphs do
    xml.graph  :gid => 1,:color => "#0000CC", :fill_color => "#0000CC" do
      @remaining_term.each_with_index do |loan, index|
        value =  loan.loan_due_in_periods
        xml.value value, :xid => index, :color => "#F4B50E"
               
      end
    end 
  end
  
end