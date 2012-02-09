module DateUtils
  
  def self.years_between(start, finish)
    difference = finish.year - start.year
    difference -= 1 if difference > 0 && (finish.month < start.month || finish.day < start.day)
    difference
  end

end
