class HouseholdNote < ActiveRecord::Base
  belongs_to :household

  def to_label
    "#{note}"
  end
end
