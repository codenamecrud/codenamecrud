module ApplicationHelper
  def markdown(text)
    Kramdown::Document.new(text, coderay_line_numbers: nil).to_html.html_safe
  end

  def breadcrumbs
    crumbs = []
    if @course
      crumbs << capture { link_to 'Список курсов', courses_path }
      if @lesson
        crumbs << capture { link_to @lesson.course.title, course_path(@lesson.course) }
        crumbs << capture { link_to @lesson.section.title, course_path(@lesson.course, anchor: "section-#{@lesson.section.slug}") }
        crumbs << capture { @lesson.title }
      end
    end

    crumbs.join(' >> ').html_safe
  end

end
