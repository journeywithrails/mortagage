class AddOriginalLoanToProposal < ActiveRecord::Migration
  def self.up
    add_column "proposal", "original_loan_id", :integer
    add_fk(:proposal, :loan, :fk_column => :original_loan_id)
  end

  def self.down
    drop_fk(:proposal, :loan, :fk_column => :original_loan_id)
    remove_column "proposal", "original_loan_id"
  end
end
