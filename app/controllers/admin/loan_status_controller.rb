class Admin::LoanStatusController < AdminController
  active_scaffold :loan_status do |config|
    config.columns = [:status_name]
    config.actions.exclude :create, :delete, :search
  end
end
