# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def flash_notices
    [:notice, :error].collect {|type| content_tag('div', flash[type], :id => type) if flash[type] }
  end
  
  def field_dom_id(object, field)
    object.class.name.underscore + "_" + field.to_s
  end

  # Render a submit button and cancel link
  def submit_or_cancel(cancel_url = session[:return_to] ? session[:return_to] : url_for(:action => 'index'), label = 'Save Changes')
    content_tag(:div, submit_tag(label) + ' or ' +
        link_to('Cancel', cancel_url), :id => 'submit_or_cancel', :class => 'submit')
  end
  
    
  # file column helpers
        
  def file_column_thumbnail(column_name, record)
    return nil if record.send(column_name).nil?
    link_to( 
      image_tag(url_for_file_column(record, column_name, "thumb"), :border => 0), 
      url_for_file_column(record, column_name), 
      :popup => true)
  end
  
  def input_file_column(column_name, record)
    if record.send(column_name) 
      # we already have a value?  display the form for deletion.
      content_tag(
        :div, 
        content_tag(
          :div, 
          file_column_thumbnail(column_name, record) + " " +
            hidden_field(record.class.name.underscore, "delete_#{column_name}", :value => "false") +
            " | " +
            link_to_function(as_("Remove file"), "$(this).previous().value='true'; p=$(this).up(); p.hide(); p.next().show();"),
          {}
        ) +
          content_tag(
          :div,
          file_column_field(record.class.name.underscore, column_name),
          :style => "display: none"
        ),
        {}
      )
    else
      # no, just display the file_column_field
      file_column_field(record.class.name.underscore, column_name)
    end
  end

  # percent labels

  def pct_label(value)
    "#{value.to_s}%" unless value.blank? unless value.nil?
  end
  
  def divide_pct_label(numerator, denominator)
    pct_label(100*numerator/denominator) unless (denominator == 0) unless numerator.nil? unless denominator.nil?
  end
  

  # Renders the help icon.
  #
  # params:
  # filename - the result of calling __FILE__ in the partial that is
  # using this help method.
  def render_box_arrow(filename, title, div_class="Heading01a")
    filename = filename.gsub("#{RAILS_ROOT}/app/views/", '');
    render :partial => "/active_scaffold_overrides/boxarrow", :locals => {:help_file_name => filename, :title => title, :div_class => div_class}
  end

  def colored_currency_label(value, precision = 0)
    # TODO - use class for green for positive numbers, red for negative

    css_class = value < 0 ? "ColorText01-todo" : "ColorText01"

    %(<span class="#{css_class}">#{number_to_currency(value, :precision=>precision)}</span>)
  end
end
