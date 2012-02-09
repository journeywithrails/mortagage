xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.chart do
  xml.series do 
    
    2.times do |loan|
      value = loan*1000
      index = loan+1
      case value
      when 0
        xml.value "Original 30 Years Fixed", :xid => index, :color => "#FFFF99"
      when 1000
        xml.value "New 30 Years Fixed", :xid => index, :color => "#FFEFCF"
      else
        xml.value value, :xid => index, :color => "#FF6600"
      end
	      
    end
  end
   
  xml.graphs do
    xml.graph  :gid => 1,:color => "#F4B50E", :fill_color => "#F4B50E",:title=>"Loan Payment" do
      	  
      xml.value @base_value.total_monthly_payment, :xid => 1, :color => "#F4B50E"
      
      xml.value @thirtyyrs_fixed.total_monthly_payment, :xid => 2, :color => "#F4B50E"
    end 
    xml.graph  :gid => 2,:color => "#C72C95",:title=>"Monthly Savings" do
     		
      xml.value @base_value.total_monthly_payment - @thirtyyrs_fixed.total_monthly_payment, :xid => 2, :color => "#C72C95"
       
       
    end 
  end
  
end