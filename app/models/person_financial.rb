class PersonFinancial < ActiveRecord::Base
  belongs_to :person, :class_name => 'Person', :foreign_key => :person_id

  validates_numericality_of :experian_credit_score, :allow_nil => true, :only_integer => true
  validates_numericality_of :equifax_credit_score, :allow_nil => true, :only_integer => true
  validates_numericality_of :transunion_credit_score, :allow_nil => true, :only_integer => true
  validates_numericality_of :base_income_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :overtime_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :bonuses_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :commissions_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :net_rental_income_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :other_income_in_cents, :allow_nil => true, :only_integer => true
  validates_numericality_of :median_credit_score, :allow_nil => true, :only_integer => true

  def parsed_dependents
#    return @dependents if @dependents
    @dependents = []
    return @dependents unless self.dependent_ages
    ages = self.dependent_ages.split(/[^\w.<>]/) # split on all punctuation except period
    last_age = nil
    ages.each do |age|
      if age != ""
        age_num = Float(age) rescue false
        if age_num
          @dependents << "#{last_age} years" if last_age
          last_age = age_num
        else
          if last_age && last_age >= 1 && age =~ /^[m|M]\w*/ #if we start with m it is probably some attempt at the word month
            @dependents << "#{last_age} months"
          elsif last_age #Otherwise assume years
            @dependents << "#{last_age} years"
            @dependents << "#{age}"
          end
          last_age = nil
        end
      end
    end
    @dependents << "#{last_age} years" if last_age
    @dependents
  end
end
