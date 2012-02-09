class Admin::TaskClassController < AdminController
  
  active_scaffold :task_class do |config|
    config.actions.exclude :create, :update, :delete, :search
  end
  
end
