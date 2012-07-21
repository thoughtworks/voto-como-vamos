module MainSearchesHelper

  def formatted_highlight(hit, field)
    hit.highlight(field).format do |fragment|
      content_tag :span, fragment, :class => 'termobuscado'
    end.html_safe
  end

end
