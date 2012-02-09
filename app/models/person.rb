include DateUtils

class Person < ActiveRecord::Base
  belongs_to :household, :class_name => 'Household', :foreign_key => :household_id

  has_many :households_as_head_of_hh_person, :class_name => 'Household', :foreign_key => :head_of_hh_person_id
  has_many :loans_as_borrower_person, :class_name => 'Loan', :foreign_key => :borrower_person_id
  has_many :loans_as_co_borrower_person, :class_name => 'Loan', :foreign_key => :co_borrower_person_id
  has_many :person_financials, :class_name => 'PersonFinancial', :foreign_key => :person_id
  has_many :accounts, :through => :households
  has_many :users, :through => :households
  has_many :rates, :through => :loans
  has_many :properties, :through => :loans
  has_many :loan_types, :through => :loans
  has_many :borrower_people, :through => :loans_as_borrower_person
  has_many :calyx_records, :through => :loans
  has_many :rates, :through => :loans
  has_many :properties, :through => :loans
  has_many :co_borrower_people, :through => :loans_as_co_borrower_person
  has_many :loan_types, :through => :loans
  has_one :latest_person_financial, :class_name => 'PersonFinancial', :order => "date desc, id desc"
  
  validates_length_of :first_name, :allow_nil => true, :maximum => 45
  validates_length_of :middle_name, :allow_nil => true, :maximum => 45
  validates_length_of :last_name, :allow_nil => true, :maximum => 45
  validates_length_of :person_guid, :allow_nil => true, :maximum => 45
  validates_length_of :ssn, :allow_nil => true, :maximum => 12
  validates_length_of :phone_home, :allow_nil => true, :maximum => 15
  validates_length_of :phone_work, :allow_nil => true, :maximum => 15
  validates_length_of :phone_mobile, :allow_nil => true, :maximum => 15
  validates_length_of :fax, :allow_nil => true, :maximum => 15
  validates_length_of :email, :allow_nil => true, :maximum => 80  
  validates_length_of :address1, :allow_nil => true, :maximum => 255
  validates_length_of :address2, :allow_nil => true, :maximum => 255
  validates_length_of :city, :allow_nil => true, :maximum => 45
  validates_length_of :state, :allow_nil => true, :maximum => 5
  validates_length_of :zip, :allow_nil => true, :maximum => 15

  def to_label
    "#{first_name} #{last_name}"
  end 

  # get the address in a form suitable for printing
  # 
  # Currently the only style is :compact
  def address(style=:compact)
    style = :compact unless style
    style = style.to_sym
    case
    when :compact  then "#{address1}, #{city}, #{state} #{zip}"
    end
  end
  
  # Returns the exact age known, or
  # '~36' if we are about 36, or 'unknown'
  # if the age is unknown.
  def age_in_years
    # if we have an exact age then use that
    if exact_dob
      return DateUtils.years_between(exact_dob, Time.now)
    end
  
    # if we have a range then use the midpoint
    if min_dob && max_dob
      daysRange = (max_dob - min_dob).to_i
      midPoint = min_dob + (daysRange/2)
      return "~" + DateUtils.years_between(midPoint, Time.now).to_s
    end
    
    # we have no idea
    "unknown"
  end
end
