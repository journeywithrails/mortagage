module Admin::LoanHelper
  
  def loan_amount_column(loan)
    number_to_currency(loan.loan_amount, :precision => 0)
  end
  
  def final_balloon_payment_column(loan)
    number_to_currency(loan.final_balloon_payment.to_f)
  end  

  def note_rate_column(loan)
    "#{loan.note_rate}%" unless loan.note_rate == nil
  end

  def margin_rate_column(loan)
    "#{loan.margin_rate}%" unless loan.margin_rate == nil
  end
  
  def rate_column(loan)
    "#{loan.rate}" unless loan.rate == nil
  end

end