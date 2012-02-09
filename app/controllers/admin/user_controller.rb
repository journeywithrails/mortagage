class Admin::UserController < AdminController
  active_scaffold :user do |config|
    config.list.columns = [:name, :account, :email, :admin, :city, :state, :photo_file, :created_at, :updated_at]
    config.update.columns = [:name, :email, :admin, :address1, :address2, :city, :state, :zip, :phone_work, :phone_mobile, :fax, :photo_file]
    list.sorting = {:name => :asc}
    config.actions.exclude  :show, :search, :create
  end  
end
