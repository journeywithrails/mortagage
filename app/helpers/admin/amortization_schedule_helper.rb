module Admin::AmortizationScheduleHelper
  
  def rate_column(amortization_schedule)
    if amortization_schedule.rate.nil?
      ""
    else
      sprintf("%.3f%", amortization_schedule.rate)
    end
  end
  
  def interest_column(amortization_schedule)
    value = (amortization_schedule.interest < 0) ? - amortization_schedule.interest : amortization_schedule.interest
    number_to_currency(value.to_f)
  end
  
  def principle_column(amortization_schedule)
    value = (amortization_schedule.principle < 0) ? - amortization_schedule.principle : amortization_schedule.principle
    number_to_currency(value.to_f)
  end
  
  def remaining_bal_column(amortization_schedule)
    number_to_currency(amortization_schedule.remaining_bal.to_f)
  end

end