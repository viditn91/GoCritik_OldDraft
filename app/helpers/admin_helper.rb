module AdminHelper
  def add_field_button(name, where, html_options, render_options)
    html = render(render_options)
    # Here the JS is appending the form to add-in a new field
    button_to_function name, "$(function(e) {
      $('##{where}').append(#{html.to_json});
    })", class: html_options[:class]
  end
end
