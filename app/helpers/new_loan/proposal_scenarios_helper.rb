module NewLoan::ProposalScenariosHelper
  def fee_input(model, column_name, scenario_object)
    html = ''
    column_name.gsub!(/_in_cents/,'')
    unless column_name =~ /id$/
      html += "<td>"
      html += "<label for='#{model}_#{column_name}'>" + column_name.humanize + "</label>"
      html += text_field(model, column_name, :style => 'width:6em') 
      html += "</td>"
      html += type_radios(model, cost_type_field(column_name, scenario_object))
    end
    return html
  end

  def type_radios(model, column_name)
    return '' unless column_name
    html = ''
    CostType.all.each do |cost_type|   
      html += "<td>"
      html += radio_button model, column_name, cost_type.id
      html += "</td>"
    end
    html
  end

  def cost_type_field(column_name, scenario_object)
    column_name.gsub!(/_fee$/,'')
    column_name.gsub!(/_amount$/,'')
    column_name.gsub!(/_pct$/,'')
    cost_type_field = column_name + "_cost_type_id"
    scenario_object.class.column_names.include?(cost_type_field) ? cost_type_field : nil
  end

  def fees_header_row
    html = ''
    html += "<tr><td></td>"
    CostType.all.each_with_index do |cost_type, index|
      html += "<td>#{cost_type.name}</td>"
    end
    html + "</tr>"
  end
end
