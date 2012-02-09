require 'test_helper'
 
class TimFooTest < ActiveSupport::TestCase
  include TimFoo
  def test_interest_rate_hundred_thousand_dollar_loan_thousand_dollar_closing
    puts "\n"
    print_rate(95500, 3000, 0.055)
    print_rate(100000, 1000, 0.07)
    print_rate(250000, 5000, 0.0625)
    print_rate(525000, 25230, 0.0432)
  end
  
  def print_rate(pv, closing, interest)
    pmt = payment(interest/12, 360, pv  + closing)
    i = interest_rate(360, pmt, pv)
    puts "Loan with PV=#{pv}, N=360, i=#{interest}/12 closing costs=#{closing} has periodic interest rate of #{i.round(7)}, APR is #{(i*12*100).round(5)}%\n"
  end
end
