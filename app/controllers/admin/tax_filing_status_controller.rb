class Admin::TaxFilingStatusController < AdminController
  active_scaffold :tax_filing_status do |config|
    list.sorting = {:name => :desc}
    config.actions.exclude  :show, :search
  end
end
