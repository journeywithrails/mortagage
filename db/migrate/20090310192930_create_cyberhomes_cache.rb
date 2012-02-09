class CreateCyberhomesCache < ActiveRecord::Migration
  def self.up

    execute "CREATE TABLE cyberhomes_cache (
	      id int(11) NOT NULL auto_increment,
	      street_address varchar(255) default NULL,
	      city_state_zip varchar(255) default NULL,
	      latitude float default NULL,
	      longitude float default NULL,
	      value_in_cents int(11) default NULL,
	      output_street varchar(255) default NULL,
	      output_zip varchar(10) default NULL,
	      output_city varchar(45) default NULL,
	      output_state varchar(4) default NULL,
	      date_queried datetime default NULL,
	      date_valued date default NULL,
	      use_code varchar(45) default NULL,
	      tax_assessment_year varchar(45) default NULL,
	      tax_assessment varchar(45) default NULL,
	      year_built varchar(45) default NULL,
	      lot_size_sq_ft varchar(45) default NULL,
	      bathrooms varchar(45) default NULL,
	      bedrooms varchar(45) default NULL,
	      last_sold_date varchar(45) default NULL,
	      last_sold_price varchar(45) default NULL,
	      failed_to_match tinyint(1) default '0',
	      PRIMARY KEY  (id),
	      KEY streetzipch (street_address,city_state_zip,date_queried))"

    execute "insert into valuation_type (id,name) values (4,'Cyberhomes');"
  end

  def self.down

    execute "DROP TABLE cyberhomes_cache"
    execute "delete from property_valuation where valuation_type_id = 4"
    execute "delete from valuation_type where id = 4"
  end
end
