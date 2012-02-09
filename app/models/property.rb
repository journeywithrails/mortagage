class Property < ActiveRecord::Base
  belongs_to :household, :class_name => 'Household', :foreign_key => :household_id
  belongs_to :property_use, :class_name => 'PropertyUse', :foreign_key => :property_use_id
  belongs_to :housing_type, :class_name => 'HousingType', :foreign_key => :housing_type_id
  
  has_many :loans, :class_name => 'Loan', :foreign_key => :property_id
  has_many :properties_for_rent, :class_name => 'PropertyForRent', :foreign_key => :property_id
  has_many :properties_for_sale, :class_name => 'PropertyForSale', :foreign_key => :property_id
  has_many :property_valuations, :class_name => 'PropertyValuation', :foreign_key => :property_id
  has_many :proposals, :class_name => 'Proposal', :foreign_key => :property_id
  has_many :refi_properties, :class_name => 'RefiProperty', :foreign_key => :property_id
  has_many :property_uses, :through => :loans
  has_many :rates, :through => :loans
  has_many :co_borrower_people, :through => :loans_as_co_borrower_person
  has_many :loan_types, :through => :loans
  has_many :users, :through => :loans
  has_many :borrower_people, :through => :loans_as_borrower_person
  has_many :valuation_types, :through => :property_valuations
  has_many :households, :through => :proposals
  has_many :property_valuations, :through => :refi_properties
  has_many :refi_scenarios, :through => :refi_properties, :conditions => "refi_property.keep_original_loans = 0"
  
  validates_length_of :address1, :allow_nil => true, :maximum => 255
  validates_length_of :address2, :allow_nil => true, :maximum => 255
  validates_length_of :city, :allow_nil => true, :maximum => 45
  validates_length_of :state, :allow_nil => true, :maximum => 5
  validates_length_of :zip, :allow_nil => true, :maximum => 15
  validates_numericality_of :purchase_price_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :estimated_tax_amt_in_cents, :allow_nil => true, :only_integer => true
  
  def to_label
    "#{address1} #{city}, #{state}"
  end

  def city_state_zip
    "#{city}, #{state} #{zip}"
  end

  def property_address
    "#{address1}, #{city}, #{state}, #{zip}"
  end

  def zillow_value
    @zillow_valuation ||= PropertyValuation.find(
      :first,
      :conditions=>["property_id = ? and valuation_type_id = ?", id, PropertyValuation::ZILLOW],
      :order=>"date desc")

    if @zillow_valuation then
      @zillow_valuation.value
    else
      nil
    end
  end

  def appraisal_value
    @appraisal_valuation ||= PropertyValuation.find(
      :first,
      :conditions=>["property_id = ? and (valuation_type_id = ? or valuation_type_id = ?)",
        id, PropertyValuation::APPRAISAL, PropertyValuation::SALE_PRICE],
      :order=>"date desc")

    if @appraisal_valuation then
      @appraisal_valuation.value
    else
      nil
    end
  end

  def latest_value
	  @latest_valuation ||= PropertyValuation.find(
      :first,
      :conditions=>["property_id = ?", id],
      :order=>"date desc")

    if @latest_valuation then
      @latest_valuation.value
    else
      nil
    end
	end

  # note - only returns non-cashout refi scenarios
  def changed_refi_scenarios
    if @changed_refi_scenarios.nil? then
      @changed_refi_scenarios = []

      refi_scenarios.each do |rs|
        #  && rs.original_loan_changed_for_property(id)  - don't need now that we changed the refi_scenarios relationship
        @changed_refi_scenarios << rs if (rs.total_cash_out_in_cents == 0)
      end
    end

    @changed_refi_scenarios
  end

  def refi_scenario_for_new_loan_product(new_loan_product_id)
    refi_scenario = nil

    changed_refi_scenarios.each do |rs|
      rp = rs.refi_property_for_property_id(id)
      if rp then
        refi_scenario = rs if rp.refi_loan_for_new_loan_product(new_loan_product_id)
      end
    end

    refi_scenario
  end

  def monthly_savings_for_new_loan_product(new_loan_product_id)
    rs = refi_scenario_for_new_loan_product(new_loan_product_id)
    if rs then
     rs.net_monthly_payment_change < 0 ? -rs.net_monthly_payment_change : 0
    else
      0
    end
  end

end
