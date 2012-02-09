class InsertTaxFilingStatus < ActiveRecord::Migration
  def self.up
    execute "insert into tax_filing_status (name) values ('Single');"
    execute "insert into tax_filing_status (name) values ('Married Filing Jointly');"
    execute "insert into tax_filing_status (name) values ('Qualifying Widow(er)');"
    execute "insert into tax_filing_status (name) values ('Married Filing Separately');"
    execute "insert into tax_filing_status (name) values ('Head of Household');"
  end

  def self.down
    execute "delete from tax_filing_status";
  end
end
