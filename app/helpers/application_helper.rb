module ApplicationHelper
  # def markdown(text)
  #   Kramdown::Document.new(text, coderay_line_numbers: nil).to_html.html_safe
  # end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_spacing: true,
        strikethrough: true,
        superscript: true,
        space_after_headers: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def breadcrumbs
    crumbs = []
    return crumbs unless @course
    crumbs << capture { link_to 'Список курсов', pages_curriculum_path }

    return crumbs unless @lesson
    crumbs << capture { link_to @lesson.course.title, course_path(@lesson.course) }
    crumbs << capture { link_to @lesson.section.title, course_path(@lesson.course, anchor: "section-#{@lesson.section.slug}") }
    crumbs << capture { @lesson.title }
  end

  def activity_user(activity)
    User.find(activity.whodunnit.to_i)
  end

  def show_activity(activity)
    lesson = Lesson.find(activity.object.to_i)
    lesson_user = LessonUser.find_by(lesson: lesson, user: activity_user(activity))

    if lesson_user
      "#{link_to activity_user(activity).name, activity_user(activity)} выполнил #{link_to lesson.title, course_lesson_path(lesson.course, lesson)} #{nice_russian_date(lesson_user.created_at)}".html_safe
    else
      'Что-то произошло'
    end
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
