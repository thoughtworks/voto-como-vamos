module MainSearchesHelper

  def formatted_highlight(hit, field)
    highlighted_field = hit.highlight(field)
    if highlighted_field

      highlighted_field.format do |fragment|
        content_tag :span, fragment, :class => 'termobuscado'
      end.html_safe
    else
      Kernel.warn "Could not find highlight for field '#{field.inspect}': is it in the solr index?"
    end
  end

end
