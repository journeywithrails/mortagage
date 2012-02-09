class AddFicoToPersonFinancial < ActiveRecord::Migration
  def self.up
    add_column :person_financial, :fico, :integer
  end

  def self.down
    remove_column(:person_financial, :fico)
  end
end
