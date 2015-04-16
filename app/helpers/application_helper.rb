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

  def show_activity(activity)
    if activity.event == 'create'
      action = 'выполнил'
    end
    lesson = Lesson.find(activity.object.to_i)
    user = User.find(activity.whodunnit.to_i)
    "#{user.name} выполнил #{link_to lesson.title, course_lesson_path(lesson.course, lesson)}".html_safe
  end

end
