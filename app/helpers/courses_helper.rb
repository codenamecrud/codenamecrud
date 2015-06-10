module CoursesHelper
  def course_link(course, index)
    if course.is_active?
      link_to "#{index}: #{course.title}", course
    else
      content_tag(:span, "#{index}: #{course.title}", data: { toggle: 'tooltip', placement: 'bottom' }, title: 'Этот курс еще не готов, но если вы оставите нам ваш email, мы пришлем вам письмо, когда он станет доступен!')
    end
  end
end
