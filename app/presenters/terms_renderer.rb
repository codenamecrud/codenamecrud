class TermsRenderer

  IGNORED_ELEMENTS = ['code', 'a']

  attr_accessor :highlite_class

  def initialize(html_text)
    @source_text = html_text.clone
    @highlight_class ||= 'vocabulary-highlight'
  end

  def render
    return '' if @source_text.blank?
    vocabularies = Terms.order 'origin_name, name'
    html_string = Nokogiri::HTML::DocumentFragment.parse @source_text
    html_string.traverse do |el|
      # if node is text content and parent isn't include elements from arr IGNORED_ELEMENTS
      if el.text? && !IGNORED_ELEMENTS.include?(el.parent.name)
        change_source_text el.content, vocabularies unless el.content.blank?
      end
    end
    @source_text
  end

  def change_source_text(element_content, terms)
    positions = {}
    terms.each do |term|
      next if term.parsed
      term_full_name = term.full_name.downcase
      if element_content.downcase.include? term_full_name
        positions[:begin] = @source_text.downcase.index term_full_name
        positions[:end] = (term_full_name.length - 1) + positions[:begin]
        @source_text[positions[:begin]..positions[:end]] = "<span #{html_attr(term)}>#{term.full_name}</span>"
        term.parsed = true
        element_content.slice! term.full_name
      end
    end
  end

  def html_attr(term)
    "class='#{@highlight_class}' data-toggle='tooltip' data-placement='top' title=\"#{term.description} <a href='#{term.url}'>Подробно</a>\""
  end

end
