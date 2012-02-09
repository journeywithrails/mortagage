class AddEstimatedTaxAmtToProperty < ActiveRecord::Migration
  def self.up
    execute "alter table property add column estimated_tax_amt integer"
  end

  def self.down
    execute "alter table property drop column estimated_tax_amt"
  end
end
