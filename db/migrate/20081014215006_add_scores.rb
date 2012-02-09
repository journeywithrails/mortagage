class AddScores < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE `property` ADD COLUMN `mae_index` integer NULL DEFAULT NULL;"
    execute "ALTER TABLE `proposal` ADD COLUMN `score` integer NULL DEFAULT NULL;"
    execute "ALTER TABLE `proposal_scenario` ADD COLUMN `score` integer NULL DEFAULT NULL;"
  end

  def self.down
  end
end
