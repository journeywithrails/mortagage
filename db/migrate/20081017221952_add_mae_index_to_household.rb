class AddMaeIndexToHousehold < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE household ADD COLUMN `mae_index` integer NULL DEFAULT NULL;"
    execute "ALTER TABLE property DROP COLUMN `mae_index`;"
  end

  def self.down
  end
end
