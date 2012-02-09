class AddLastlogin < ActiveRecord::Migration
  def self.up
    add_column :user, :last_login_at, :date
    add_column :user, :previous_login_at, :date
  end

  def self.down
    remove_column :user, :last_login_at
    remove_column :user, :previous_login_at
  end
end
