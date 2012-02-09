class Common::LoanStatusController < ApplicationController
  active_scaffold :loan_status do |config|
    config.columns = [:status_name]
    config.actions.exclude :create, :delete, :update, :modify, :search
  end
end
