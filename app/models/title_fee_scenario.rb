class TitleFeeScenario < ActiveRecord::Base
  belongs_to :settlement_cost_type, :class_name => 'CostType', :foreign_key => :settlement_cost_type_id
  belongs_to :city_county_cost_type, :class_name => 'CostType', :foreign_key => :city_county_cost_type_id
  belongs_to :closing_cost_type, :class_name => 'CostType', :foreign_key => :closing_cost_type_id
  belongs_to :commitment_cost_type, :class_name => 'CostType', :foreign_key => :commitment_cost_type_id
  belongs_to :endorsement_cost_type, :class_name => 'CostType', :foreign_key => :endorsement_cost_type_id
  belongs_to :exam_cost_type, :class_name => 'CostType', :foreign_key => :exam_cost_type_id
  belongs_to :lender_policy_cost_type, :class_name => 'CostType', :foreign_key => :lender_policy_cost_type_id
  belongs_to :notary_cost_type, :class_name => 'CostType', :foreign_key => :notary_cost_type_id
  belongs_to :owners_policy_cost_type, :class_name => 'CostType', :foreign_key => :owners_policy_cost_type_id
  belongs_to :inspection_cost_type, :class_name => 'CostType', :foreign_key => :inspection_cost_type_id
  belongs_to :recording_cost_type, :class_name => 'CostType', :foreign_key => :recording_cost_type_id
  belongs_to :title_insurance_cost_type, :class_name => 'CostType', :foreign_key => :title_insurance_cost_type_id
  belongs_to :title_search_cost_type, :class_name => 'CostType', :foreign_key => :title_search_cost_type_id
  belongs_to :state_cost_type, :class_name => 'CostType', :foreign_key => :state_cost_type_id
  belongs_to :survey_cost_type, :class_name => 'CostType', :foreign_key => :survey_cost_type_id
  has_many :proposal_scenario, :class_name => 'ProposalScenario', :foreign_key => :title_fee_scenario_id
  has_many :proposals, :through => :proposal_scenario
#  has_many :closing_scenario, :through => :proposals
#  has_many :property, :through => :proposal
#  has_many :household, :through => :proposal
  
  validates_numericality_of :settlement_fee_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :city_county_fee_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :closing_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :commitment_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :endorsement_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :exam_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :lender_policy_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :notary_fee_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :owners_policy_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :inspection_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :recording_fee_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :title_insurance_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :title_search_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :state_fee_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :survey_fee_in_cents, :allow_nil => true, :only_integer => true
  
  def to_label
    "#{name}"
  end
end
