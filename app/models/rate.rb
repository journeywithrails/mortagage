class Rate < ActiveRecord::Base
  has_one :latest_historical_rate, :class_name => 'HistoricalRate', :foreign_key => :rate_id, :order => 'date desc'

  has_many :historical_rates, :class_name => 'HistoricalRate', :foreign_key => :rate_id
  has_many :loans, :class_name => 'Loan', :foreign_key => :rate_id

  #  has_many :properties, :through => :loans
#  has_many :co_borrower_people, :through => :loans_as_co_borrower_person
#  has_many :loan_types, :through => :loans
#  has_many :users, :through => :loans
#  has_many :borrower_people, :through => :loans_as_borrower_person

  validates_length_of :name, :allow_nil => true, :maximum => 45
  validates_numericality_of :fmae_index_type, :allow_nil => true, :only_integer => true
    
end