xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.chart do
  
  xml.series do    
    @current_loan_balance.each_with_index do |loan, index|
      xml.value loan.address1, :xid => index  
    end
  end
  
  xml.graphs do
    xml.graph  :gid => 1,:color => "#0000CC", :fill_color => "#0000CC" do
      @current_loan_balance.each_with_index do |loan, index|
        value =  loan.loan_amount
        xml.value value, :xid => index, :color => "#F4B50E"
        case value
        when 0..10000
          xml.value value, :xid => index, :color => "#FFFF99"
        when 10000..100000
          xml.value value, :xid => index, :color => "#FFEFCF"
        when 100000..500000
          xml.value value, :xid => index, :color => "#FFCC66"
        when 500000..1000000
          xml.value value, :xid => index, :color => "#F4B50E"
        else
          xml.value value, :xid => index, :color => "#FF6600"
        end
        
      end
    end 
  end
  
end