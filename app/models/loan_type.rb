class LoanType < ActiveRecord::Base
  has_many :loans, :class_name => 'Loan', :foreign_key => :loan_type_id
  has_many :refi_loans, :class_name => 'RefiLoan', :foreign_key => :loan_type_id
  has_many :rates, :through => :loans
  has_many :properties, :through => :loans
  has_many :co_borrower_people, :through => :loans_as_co_borrower_person
  has_many :users, :through => :loans
  has_many :borrower_people, :through => :loans_as_borrower_person
  
  validates_length_of :name, :allow_nil => true, :maximum => 45

  def self.fixed_rate_type
    2
  end

  def self.arm_type
    4
  end
end
