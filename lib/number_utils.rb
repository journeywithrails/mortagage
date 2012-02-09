require 'bigdecimal/util'

class Integer < Numeric
  def to_d
    BigDecimal.new(self.to_s)
  end
end

class BigDecimal
  def to_d
    self
  end
end

class Numeric
  def to_currency
    '$' << ('%.2f' % self.to_d.round(2)).reverse.scan(/(?:\d*\.)?\d{1,3}-?/).join(',').reverse
  end
end

class ActiveRecord::Base
  def format_cents_as_currency(cents)
    dollars = ""
    dollars = "$" << sprintf("%0d", cents/100) unless cents == nil
    dollars.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
  end  
end

