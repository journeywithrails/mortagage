class CostType < ActiveRecord::Base
  has_many :closing_scenario_as_origination_cost_type, :class_name => 'ClosingScenario', :foreign_key => :origination_cost_type_id
  has_many :closing_scenario_as_discount_cost_type, :class_name => 'ClosingScenario', :foreign_key => :discount_cost_type_id
  has_many :closing_scenario_as_application_cost_type, :class_name => 'ClosingScenario', :foreign_key => :application_cost_type_id
  has_many :closing_scenario_as_appraisal_cost_type, :class_name => 'ClosingScenario', :foreign_key => :appraisal_cost_type_id
  has_many :closing_scenario_as_commitment_cost_type, :class_name => 'ClosingScenario', :foreign_key => :commitment_cost_type_id
  has_many :closing_scenario_as_credit_report_cost_type, :class_name => 'ClosingScenario', :foreign_key => :credit_report_cost_type_id
  has_many :closing_scenario_as_document_preparation_cost_type, :class_name => 'ClosingScenario', :foreign_key => :document_preparation_cost_type_id
  has_many :closing_scenario_as_extension_cost_type, :class_name => 'ClosingScenario', :foreign_key => :extension_cost_type_id
  has_many :closing_scenario_as_flood_certificate_cost_type, :class_name => 'ClosingScenario', :foreign_key => :flood_certificate_cost_type_id
  has_many :closing_scenario_as_funding_cost_type, :class_name => 'ClosingScenario', :foreign_key => :funding_cost_type_id
  has_many :closing_scenario_as_postage_cost_type, :class_name => 'ClosingScenario', :foreign_key => :postage_cost_type_id
  has_many :closing_scenario_as_service_cost_type, :class_name => 'ClosingScenario', :foreign_key => :service_cost_type_id
  has_many :closing_scenario_as_tax_service_cost_type, :class_name => 'ClosingScenario', :foreign_key => :tax_service_cost_type_id
  has_many :closing_scenario_as_underwriting_cost_type, :class_name => 'ClosingScenario', :foreign_key => :underwriting_cost_type_id
  has_many :closing_scenario_as_wire_transfer_cost_type, :class_name => 'ClosingScenario', :foreign_key => :wire_transfer_cost_type_id
  has_many :closing_scenario_as_processing_cost_type, :class_name => 'ClosingScenario', :foreign_key => :processing_cost_type_id
  has_many :title_fee_scenario_as_settlement_cost_type, :class_name => 'TitleFeeScenario', :foreign_key => :settlement_cost_type_id
  has_many :title_fee_scenario_as_city_county_cost_type, :class_name => 'TitleFeeScenario', :foreign_key => :city_county_cost_type_id
  has_many :title_fee_scenario_as_closing_cost_type, :class_name => 'TitleFeeScenario', :foreign_key => :closing_cost_type_id
  has_many :title_fee_scenario_as_commitment_cost_type, :class_name => 'TitleFeeScenario', :foreign_key => :commitment_cost_type_id
  has_many :title_fee_scenario_as_endorsement_cost_type, :class_name => 'TitleFeeScenario', :foreign_key => :endorsement_cost_type_id
  has_many :title_fee_scenario_as_exam_cost_type, :class_name => 'TitleFeeScenario', :foreign_key => :exam_cost_type_id
  has_many :title_fee_scenario_as_lender_policy_cost_type, :class_name => 'TitleFeeScenario', :foreign_key => :lender_policy_cost_type_id
  has_many :title_fee_scenario_as_notary_cost_type, :class_name => 'TitleFeeScenario', :foreign_key => :notary_cost_type_id
  has_many :title_fee_scenario_as_owners_policy_cost_type, :class_name => 'TitleFeeScenario', :foreign_key => :owners_policy_cost_type_id
  has_many :title_fee_scenario_as_inspection_cost_type, :class_name => 'TitleFeeScenario', :foreign_key => :inspection_cost_type_id
  has_many :title_fee_scenario_as_recording_cost_type, :class_name => 'TitleFeeScenario', :foreign_key => :recording_cost_type_id
  has_many :title_fee_scenario_as_title_insurance_cost_type, :class_name => 'TitleFeeScenario', :foreign_key => :title_insurance_cost_type_id
  has_many :title_fee_scenario_as_title_search_cost_type, :class_name => 'TitleFeeScenario', :foreign_key => :title_search_cost_type_id
  has_many :title_fee_scenario_as_state_cost_type, :class_name => 'TitleFeeScenario', :foreign_key => :state_cost_type_id
  has_many :title_fee_scenario_as_survey_cost_type, :class_name => 'TitleFeeScenario', :foreign_key => :survey_cost_type_id
  
  validates_presence_of :name
  validates_length_of :name, :allow_nil => false, :maximum => 45
end
