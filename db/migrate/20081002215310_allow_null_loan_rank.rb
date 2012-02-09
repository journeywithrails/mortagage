class AllowNullLoanRank < ActiveRecord::Migration
  def self.up
    change_column :loan, :loan_rank, :integer, :null => true
  end

  def self.down
    change_column :loan, :loan_rank, :integer, :null => false
  end
end
