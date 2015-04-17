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
    lesson = Lesson.find(activity.object.to_i)
    user = User.find(activity.whodunnit.to_i)
    lesson_user = LessonUser.find_by(lesson: lesson, user: user)

    "#{user.name} выполнил #{link_to lesson.title, course_lesson_path(lesson.course, lesson)} в #{nice_russian_date(lesson_user.created_at)}".html_safe
  end

  def nice_russian_date(date)
    "#{time_ago_in_words(date)} назад"
  end


end
