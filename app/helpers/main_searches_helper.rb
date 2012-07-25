module MainSearchesHelper

  def formatted_highlight(hit, field)
    highlighted_field = hit.highlight(field)
    if highlighted_field

      highlighted_field.format do |fragment|
        content_tag :span, fragment, :class => 'termobuscado'
      end.html_safe
    else
      value = hit.stored(field)
      value.kind_of?(Array) ? value.join("") : value
    end
  end

end
