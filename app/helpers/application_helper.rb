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

    crumbs
  end

  def activity_user(activity)
    User.find(activity.whodunnit.to_i)
  end

  def show_activity(activity)
    lesson = Lesson.find(activity.object.to_i)
    lesson_user = LessonUser.find_by(lesson: lesson, user: activity_user(activity))

    "#{link_to activity_user(activity).name, activity_user(activity)} выполнил #{link_to lesson.title, course_lesson_path(lesson.course, lesson)} #{nice_russian_date(lesson_user.created_at)}".html_safe
  end

  def nice_russian_date(date)
    "#{time_ago_in_words(date)} назад"
  end

  def avatar_url(user, size)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def title(text = nil)
    if text
      title = "#{text} || CodenameCRUD - бесплатное обучение веб-разработке"
    else
      title = 'CodenameCRUD - бесплатное обучение веб-разработке'
    end
    content_for :title, title
  end

end
