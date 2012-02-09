class AddPropertyForSaleRent < ActiveRecord::Migration
  def self.up

    execute "drop table if exists property_for_rent"
    execute "drop table if exists property_for_sale"

    execute "CREATE TABLE `property_for_sale` (
      `id` int(11) NOT NULL auto_increment,
      `property_id` int(11) NOT NULL,
      `address1` varchar(255) default NULL,
      `address2` varchar(255) default NULL,
      `city` varchar(45) default NULL,
      `state` varchar(5) default NULL,
      `zip` varchar(15) default NULL,
      `bedrooms` int(11) default NULL,
      `bathrooms` int(11) default NULL,
      `area` int default NULL,
      `price_in_cents` int default NULL,
      `url` varchar(255) default NULL,
      PRIMARY KEY  (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;"

    execute "CREATE TABLE `property_for_rent` (
      `id` int(11) NOT NULL auto_increment,
      `property_id` int(11) NOT NULL,
      `address1` varchar(255) default NULL,
      `address2` varchar(255) default NULL,
      `city` varchar(45) default NULL,
      `state` varchar(5) default NULL,
      `zip` varchar(15) default NULL,
      `bedrooms` int(11) default NULL,
      `bathrooms` int(11) default NULL,
      `area` int default NULL,
      `price_in_cents` int default NULL,
      `url` varchar(255) default NULL,
      PRIMARY KEY  (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;"

  end

  def self.down
    execute "drop table property_for_rent"
    execute "drop table property_for_sale"
  end
end
