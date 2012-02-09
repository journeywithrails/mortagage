class AddNewLoanAssociationToLoan < ActiveRecord::Migration

  def self.up
    add_column :loan, :new_loan_product_id, :integer
    add_column "new_loan_product", "is_custom", :boolean, :default => false
    add_column "new_loan_product", "interest_only_term", :integer, :default => 0
    NewLoanProduct.create!(:name => 'Custom', :is_custom => 1, :lock_days => 0)
    add_fk :loan, :new_loan_product
  end

  def self.down
    NewLoanProduct.find(:all, :conditions => "is_custom = 1").each {|r| r.destroy}
    drop_fk :loan, :new_loan_product
    remove_column "new_loan_product", "interest_only_term"
    remove_column "new_loan_product", "is_custom"
    remove_column :loan, :new_loan_product_id
  end
end
