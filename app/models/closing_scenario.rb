class ClosingScenario < ActiveRecord::Base
  belongs_to :origination_cost_type, :class_name => 'CostType', :foreign_key => :origination_cost_type_id
  belongs_to :discount_cost_type, :class_name => 'CostType', :foreign_key => :discount_cost_type_id
  belongs_to :application_cost_type, :class_name => 'CostType', :foreign_key => :application_cost_type_id
  belongs_to :appraisal_cost_type, :class_name => 'CostType', :foreign_key => :appraisal_cost_type_id
  belongs_to :commitment_cost_type, :class_name => 'CostType', :foreign_key => :commitment_cost_type_id
  belongs_to :credit_report_cost_type, :class_name => 'CostType', :foreign_key => :credit_report_cost_type_id
  belongs_to :document_preparation_cost_type, :class_name => 'CostType', :foreign_key => :document_preparation_cost_type_id
  belongs_to :extension_cost_type, :class_name => 'CostType', :foreign_key => :extension_cost_type_id
  belongs_to :flood_certificate_cost_type, :class_name => 'CostType', :foreign_key => :flood_certificate_cost_type_id
  belongs_to :funding_cost_type, :class_name => 'CostType', :foreign_key => :funding_cost_type_id
  belongs_to :postage_cost_type, :class_name => 'CostType', :foreign_key => :postage_cost_type_id
  belongs_to :service_cost_type, :class_name => 'CostType', :foreign_key => :service_cost_type_id
  belongs_to :tax_service_cost_type, :class_name => 'CostType', :foreign_key => :tax_service_cost_type_id
  belongs_to :underwriting_cost_type, :class_name => 'CostType', :foreign_key => :underwriting_cost_type_id
  belongs_to :wire_transfer_cost_type, :class_name => 'CostType', :foreign_key => :wire_transfer_cost_type_id
  belongs_to :processing_cost_type, :class_name => 'CostType', :foreign_key => :processing_cost_type_id
  has_many :proposal_scenarios, :class_name => 'ProposalScenario', :foreign_key => :closing_scenario_id
  has_many :proposals, :through => :proposal_scenarios
#  has_many :properties, :through => :proposals
#  has_many :households, :through => :proposals
#  has_many :title_fee_scenarios, :through => :proposals
  
  validates_length_of :name, :allow_nil => true, :maximum => 120
  validates_numericality_of :origination_amount_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :origination_pct, :allow_nil => true
  validates_numericality_of :discount_amount_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :discount_pct, :allow_nil => true
  validates_numericality_of :application_fee_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :appraisal_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :commitment_fee_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :credit_report_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :document_preparation_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :extension_fee_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :flood_certificate_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :funding_fee_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :postage_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :processing_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :service_fee_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :tax_service_amount_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :tax_service_pct, :allow_nil => true
  validates_numericality_of :underwriting_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :wire_transfer_in_cents, :allow_nil => true, :only_integer => true
  
  def to_label
    "#{name}"
  end
end
