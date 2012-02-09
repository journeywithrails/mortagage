class ViewHouseholdLoan < ActiveRecord::Base
  belongs_to :view_household_loan_search_result, :foreign_key => :id
  belongs_to :head_of_hh_person, :class_name => :Person
  belongs_to :user, :class_name => 'BrokerUser', :foreign_key => :user_id
end
