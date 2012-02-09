class ProposalScenario < ActiveRecord::Base
  belongs_to :proposal, :class_name => 'Proposal', :foreign_key => :proposal_id
  belongs_to :closing_scenario, :class_name => 'ClosingScenario', :foreign_key => :closing_scenario_id
  belongs_to :title_fee_scenario, :class_name => 'TitleFeeScenario', :foreign_key => :title_fee_scenario_id
  has_many :proposal_scenario_loans, :class_name => 'ProposalScenarioLoan', :foreign_key => :proposal_scenario_id
  has_many :loans, :through => :proposal_scenario_loans
  
  validates_presence_of :name
  validates_length_of :name, :allow_nil => false, :maximum => 120
  validates_numericality_of :purchase_price_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :down_payment_amount_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :down_payment_pct, :allow_nil => true
  validates_numericality_of :score, :allow_nil => true, :only_integer => true

  def loan_to_value
    begin
      "%.2f%" % (((purchase_price_in_cents - down_payment_amount_in_cents).to_f / purchase_price_in_cents) * 100 ) 
    rescue
      ""
    end
  end

  def funding_required
    (purchase_price || 0) - (down_payment_amount || 0)
  end

  def loan_amount_total
    loans.inject(0) {|sum, loan| sum + loan.loan_amount }
  end
end
