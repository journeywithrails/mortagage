class RenameFicoToMedianCreditScore < ActiveRecord::Migration
  def self.up
    rename_column(:person_financial, :fico, :median_credit_score)
  end

  def self.down
    rename_column(:person_financial, :median_credit_score, :fico)
  end
end
