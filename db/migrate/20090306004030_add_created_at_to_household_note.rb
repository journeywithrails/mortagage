class AddCreatedAtToHouseholdNote < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE `household_note` ADD `created_at` DATE NULL AFTER `household_id` ;"
  end

  def self.down
    execute "ALTER TABLE `household_note` drop `created_at`;"
  end
end
