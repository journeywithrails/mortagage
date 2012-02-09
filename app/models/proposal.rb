class Proposal < ActiveRecord::Base
  belongs_to :household, :class_name => 'Household', :foreign_key => :household_id
  belongs_to :property, :class_name => 'Property', :foreign_key => :property_id
  belongs_to :user, :class_name => 'BrokerUser', :foreign_key => :user_id
  has_many :proposal_scenarios, :class_name => 'ProposalScenario', :foreign_key => :proposal_id
  has_many :closing_scenarios, :through => :proposal_scenarios
  has_many :title_fee_scenarios, :through => :proposal_scenarios
  belongs_to :original_loan, :class_name => :loan, :foreign_key => :original_loan_id
  
  validates_presence_of :name
  validates_length_of :name, :allow_nil => false, :maximum => 120

  
  # methods for recent activity module
  def activity_client
   household.to_label if !household.nil?
  end

  def activity_item
    "New Loan"
  end

  def activity_date
    updated_at
  end

  def activity_status
    "Created"
  end

  def activity_link_options
    {:controller=>"/new_loan/proposals", :action=>"edit", :id=>id}
  end
end
