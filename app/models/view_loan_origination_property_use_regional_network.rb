class ViewLoanOriginationPropertyUseRegionalNetwork < ActiveRecord::Base
  def add_values(item)
    self.count = item.count + count
  end

end
