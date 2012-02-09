class PropertyUse < ActiveRecord::Base
  has_many :loans, :class_name => 'Loan', :foreign_key => :property_use_id
  has_many :properties, :class_name => 'Property', :foreign_key => :property_use_id
  has_many :calyx_records, :through => :loans
  has_many :rates, :through => :loans
  has_many :properties, :through => :loans
  has_many :co_borrower_people, :through => :loans_as_co_borrower_person
  has_many :loan_types, :through => :loans
  has_many :users, :through => :loans
  has_many :borrower_people, :through => :loans_as_borrower_person
  has_many :households, :through => :properties
  
  validates_length_of :name, :allow_nil => true, :maximum => 45
end
