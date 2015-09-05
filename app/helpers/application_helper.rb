module ApplicationHelper
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
    content_for :title, [text, slogan].compact.join(' || ')
  end

  def slogan
    'CodenameCRUD - бесплатное обучение веб-разработке'
  end

  def next_lesson_path
    begin
      id_to_lesson = LessonUser.find_by_sql(["SELECT user_id, lesson_id FROM lesson_users WHERE user_id = ?", current_user.id])
      ids_lesson = []
      id_to_lesson.each do |item|
        ids_lesson.push(item[:lesson_id])
      end
      last_lesson_id = ids_lesson.max + 1
      lesson = Lesson.find_by(id: last_lesson_id)
      course = lesson.course
      link_to_last_lesson =  "#{course.slug}/#{lesson.slug}"
    rescue
      ""
    end
  end

  def current_lesson_now
    begin
      id_lesson = LessonUser.last(:lesson_id, user_id: current_user.id)
    rescue
      id_lesson = 0
    end
  end
end
