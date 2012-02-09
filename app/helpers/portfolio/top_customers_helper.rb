module Portfolio::TopCustomersHelper
  def total_loans_in_thousands_column(record)
   number_to_currency(record.total_loans/1000, :precision => 0)
  end

  def top_customer_column(record)
    household_overview_link(record, "#{record.top_customer}")
  end

  def no_of_loans_column(record)
    "#{record.no_of_loans}"
  end

end
