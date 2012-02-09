class AddCreatedAtToPropertyForSale < ActiveRecord::Migration
  def self.up
    add_column :property_for_sale, :created_at, :datetime
    add_column :property_for_rent, :created_at, :datetime
  end

  def self.down
    remove_column :property_for_sale, :created_at
    remove_column :property_for_rent, :created_at
  end
end
