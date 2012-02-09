# This is where we define models in Factory Girl
#
# Please watch this railscast for a factory girl tutorial:
# http://railscasts.com/episodes/158-factories-not-fixtures
#
# Define one factory for each model in the system.
#
# Only populate enough of the model to allow saving the model to
# the database.
#
# For example, proposal_scenarios require a name, so that is set
# in the factory.
# 
# Loans must have an associated property (the property_id cannot be null)
# and person so that association is set in the loan factory.

Factory.define :proposal_scenario do |proposal_scenario|
   proposal_scenario.sequence(:name) {|n| "proposal_scenario#{n}"}
end

Factory.define :property do |property|
end

Factory.define :person do |person|
  person.sequence(:first_name) {|n| "first name#{n}"}
  person.sequence(:last_name) {|n| "last name#{n}"}
  person.sequence(:address1) {|n| "xyz#{n} road, abc#{n} city, pqr#{n} country"}
  person.sequence(:city) {|n| "New York#{n}"}
  person.sequence(:state) {|n| "NY#{n}"} 
  person.association :latest_person_financial, :factory => :person_financial
end

Factory.define :person_financial do |person_finance|
  person_finance.sequence(:employer_name) {|n| "employer name#{n}"} 
end

Factory.define :loan do |loan|
  loan.association :property
  loan.association :borrower_person, :factory => :person
end

Factory.define :proposal_scenario_loan do |proposal_scenario_loan|
 proposal_scenario_loan.association :proposal_scenario, :factory => :proposal_scenario
 proposal_scenario_loan.association :loan, :factory => :loan
end

Factory.define :proposal do |proposal|
   proposal.name 'name'
   proposal.association :property, :factory => :property
   proposal.association :user, :factory => :broker_user
   proposal.association :household, :factory => :household
 end

Factory.define :household do |household|
  household.association :head_of_hh_person, :factory => :person
  household.best_mae_index 80
  household.association :user, :factory => :broker_user
  household.association :account, :factory => :broker_account
end

Factory.define :property_for_sale do |property|
  property.association :property, :factory => :property  
end

Factory.define :household_event do |event|
 event.association :household, :factory => :household
 event.is_dismissed 0
 event.sequence(:message) {|n| "message#{n}"}
end  

Factory.define :broker_user do |broker_user|
  broker_user.sequence(:email) {|n| "broker#{n}@test.host"}
  broker_user.association :account, :factory => :broker_account
end

Factory.define :broker_account do |broker_account|
end

Factory.define :household_financial do |household_financial|
end

Factory.define :tax_rate do |tax_rate|
  tax_rate.tax_pct 10
  tax_rate.association :tax_filing_status, :factory => :tax_filing_status
end

Factory.define :tax_filing_status do |tax_filing_status|
  tax_filing_status.sequence(:name) {|n| "tax filing status #{n}"}
end
