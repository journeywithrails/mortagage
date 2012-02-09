class PropertyForSale < ActiveRecord::Migration
  
  def self.up
  execute "CREATE TABLE IF NOT EXISTS property_for_sale(
  `id` int(11) NOT NULL auto_increment,
  `property_id` int(11) NOT NULL,
  `address1` varchar(255) default NULL,
  `address2` varchar(255) default NULL,
  `city` varchar(45) default NULL,
  `state` varchar(5) default NULL,
  `zip` varchar(15) default NULL,
  `bedrooms` int(11) default NULL,
  `bathrooms` varchar(15) default NULL,
  `area` float default NULL,
  `price` float default NULL,
  `url` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB;"  
  end

  def self.down
    execute "Drop table property_for_sale;"
  end
end
