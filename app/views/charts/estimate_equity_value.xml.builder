xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.chart do
  xml.series do 
    
    2.times do |loan|
      value = loan*1000
      index = loan+1
      case value
      when 0
        xml.value "Based on Last Transaction", :xid => index, :color => "#FFFF99"
      when 1000
        xml.value "Based on Zillow Estimate", :xid => index, :color => "#FFEFCF"
      else
        xml.value value, :xid => index, :color => "#FF6600"
      end
	      
    end
  end
   
  xml.graphs do
    xml.graph  :gid => 1,:color => "#F4B50E", :fill_color => "#F4B50E",:title=>"Loan Balance" do
      	  
      xml.value @loan.property.latest_value, :xid => 1, :color => "#F4B50E"
      
      xml.value @loan.property.zillow_value, :xid => 2, :color => "#F4B50E"
    end 
	
  end
  
end