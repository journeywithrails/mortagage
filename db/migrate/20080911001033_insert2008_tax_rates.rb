class  Insert2008TaxRates < ActiveRecord::Migration
  def self.up
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (1,802500,10,0);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (1,3255000,15,80250);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (1,7885000,25,448125);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (1,16455000,28,1605625);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (1,35770000,33,4005225);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (1,2147483647,35,10379175);"

    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (2,1605000,10,0);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (2,6510000,15,160500);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (2,13145000,25,896250);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (2,20030000,28,2555000);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (2,35770000,33,4482800);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (2,2147483647,35,9677000);"

    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (3,1605000,10,0);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (3,6510000,15,160500);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (3,13145000,25,896250);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (3,20030000,28,2555000);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (3,35770000,33,4482800);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (3,2147483647,35,9677000);"

    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (4,802500,10,0);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (4,3255000,15,80250);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (4,6572500,25,448125);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (4,10015000,28,1277500);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (4,17885000,33,2241400);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (4,2147483647,35,4838500);"

    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (5,1145000,10,0);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (5,4365000,15,114500);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (5,11265000,25,597500);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (5,18240000,28,2322500);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (5,35770000,33,4275500);"
    execute "insert into tax_rate (tax_filing_status_id, top_income, tax_pct, base_tax) values (5,2147483647,35,10060400);"
  end

  def self.down
    execute "delete from tax_rate;"
  end
end
