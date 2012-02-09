class Household < ActiveRecord::Base
  belongs_to :account, :class_name => 'BrokerAccount', :foreign_key => :account_id
  belongs_to :user, :class_name => 'BrokerUser', :foreign_key => :user_id
  belongs_to :head_of_hh_person, :class_name => 'Person', :foreign_key => :head_of_hh_person_id
  belongs_to :best_opportunity_type, :class_name => 'OpportunityType', :foreign_key => :best_opportunity_type_id
  belongs_to :best_refi_scenario, :class_name => 'RefiScenario', :foreign_key => :best_refi_scenario_id
  belongs_to :refinance_refi_scenario, :class_name => 'RefiScenario', :foreign_key => :refinance_refi_scenario_id
  belongs_to :consolidation_refi_scenario, :class_name => 'RefiScenario', :foreign_key => :consolidation_refi_scenario_id
  belongs_to :college_refi_scenario, :class_name => 'RefiScenario', :foreign_key => :college_refi_scenario_id
  belongs_to :retirement_refi_scenario, :class_name => 'RefiScenario', :foreign_key => :retirement_refi_scenario_id
  belongs_to :arm_watch_refi_scenario, :class_name => 'RefiScenario', :foreign_key => :arm_watch_refi_scenario_id
  
  has_many :household_financials, :class_name => 'HouseholdFinancial', :foreign_key => :household_id
  has_many :people, :class_name => 'Person', :foreign_key => :household_id
  has_many :properties, :class_name => 'Property', :foreign_key => :household_id
  has_many :tax_rates, :through => :household_financials
  has_many :proposal_properties, :through => :proposals
  has_many :household_notes, :order => "created_at desc"
  has_many :household_reports, :class_name => 'HouseholdReport', :foreign_key => :household_id
  has_many :household_events, :order => "date desc"
  has_many :properties_for_sale, :through => :properties
  has_many :refi_scenarios
  has_one :base_case_refi_scenario, :class_name => 'RefiScenario', :conditions => {:is_base_case => 1}

  validates_inclusion_of :is_dirty, :in => [true, false], :allow_nil => true, :message => ActiveRecord::Errors.default_error_messages[:blank]

  def to_label
    "#{head_of_hh_person.to_label}" if !head_of_hh_person.nil?
  end

  def address(style=:compact)
    head_of_hh_person.address(style)
  end

  def number_of_dependents
    "TODO" # TODO
    # something like:
    # head_of_hh_person.person_financials.first.parsed_dependents
  end

  def related_loans
    self.head_of_hh_person.loans_as_co_borrower_person.all(:conditions => {:user_id => self.user_id})
  end
  
end
