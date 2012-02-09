class Admin::TaxRateController < AdminController
  active_scaffold :tax_rate do |config|
    config.columns = [:tax_filing_status, :top_income, :tax_pct, :base_tax]
    config.columns[:tax_filing_status].clear_link
    list.sorting = {:tax_filing_status => :desc, :top_income => :asc}
    list.per_page = 100
    config.actions.exclude  :show, :search
  end
end
