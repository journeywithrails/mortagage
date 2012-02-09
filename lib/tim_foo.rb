module TimFoo
  
  #calculates the payment of an amortizing loan
  def payment(periodic_interest_rate, loan_term_periods, present_value, future_value = 0)
    begin
      a_value = a(periodic_interest_rate, loan_term_periods)
      b_value = b(periodic_interest_rate)
      -(future_value + present_value * (a_value + 1 )) / (a_value * b_value)
    rescue
      ""
    end
  end
 
  #returns the periodic interest rate for a loan with the specified properties
  def interest_rate(loan_term_periods, each_payment, present_value, future_value = 0, min_rate = 0.0, max_rate = 1.0, iterations = 0)    
    midpoint_rate = (min_rate + max_rate) / 2
    payment_guess = payment(midpoint_rate, loan_term_periods, present_value, future_value)
    return midpoint_rate if (payment_guess - each_payment).abs < 0.001  # if we found a rate that puts us within 0.001 of the specified payment we are done
     
    raise "Rate does not converge" if iterations == 30
    
    if  payment_guess < each_payment
      return interest_rate(loan_term_periods, each_payment, present_value, future_value, min_rate, midpoint_rate, iterations + 1) 
    else
      return interest_rate(loan_term_periods, each_payment, present_value, future_value, midpoint_rate, max_rate, iterations + 1) 
    end
  end
 
  protected
  #used in loan calculations. See Tim's calculations pdf.
  def a(periodic_interest_rate, loan_term_periods)
    ((1 + periodic_interest_rate) ** loan_term_periods) - 1
  end
  
  #used in loan calculations. See Tim's calculations pdf.
  def b(periodic_interest_rate)
    payment_timing = 0 # 1 for beginning of period, 0 for end
    (1+periodic_interest_rate * payment_timing)/periodic_interest_rate
  end

end