class ViewLoanOriginationPerformanceSummary < ActiveRecord::Base
    
  def add_values(item)
    total_count = item.count + count
    if total_count > 0 then
      self.days_to_close += ((item.days_to_close * item.count) + (days_to_close * count)) / total_count
      self.avg_loan_amount_in_cents += ((item.avg_loan_amount_in_cents * item.count) + (avg_loan_amount_in_cents * count)) / total_count
    end
    self.count = total_count
  end

end
