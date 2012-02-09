class HouseholdEvent < ActiveRecord::Base
  belongs_to :household

  def name
    # TODO - fix this for different types of events
    household.to_label if household_id
  end
end
