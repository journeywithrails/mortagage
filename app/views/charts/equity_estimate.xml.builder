xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.chart do
  
  xml.series do    
    @equity.each_with_index do |loan, index|
      xml.value loan.address1, :xid => index  
    end
  end
  
  xml.graphs do
    xml.graph  :gid => 1,:color => "#F4B50E", :fill_color => "#F4B50E",:title=>"Balance" do
      @equity.each_with_index do |loan, index|
        value =  loan.value
        xml.value value, :xid => index, :color => "#F4B50E"
      end
    end 
    xml.graph  :gid => 2,:color => "#B3DBD4", :fill_color => "#B3DBD4",:title =>"Equity(Estimate)" do
      @equity.each_with_index do |loan, index|
        value =  (loan.value.to_i - loan.loan_amount.to_i)
        xml.value value, :xid => index, :color => "#B3DBD4"
      end
    end 
  end
  
end