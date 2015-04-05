module ApplicationHelper
  def markdown(text)
    Kramdown::Document.new(text, coderay_line_numbers: nil).to_html.html_safe
  end
end
