module CoursesHelper
  def course_link(course, index, is_new = nil)
    if course.is_active?
      new_one = is_new ? '<span class="text-success">(Новый курс!)</span>' : ''
      link_to "#{index}: #{course.title} #{new_one}".html_safe, course
    else
      content_tag(:span, "#{index}: #{course.title}", data: { toggle: 'tooltip', placement: 'bottom' }, title: 'Этот курс еще не готов, но если вы оставите нам ваш email, мы пришлем вам письмо, когда он станет доступен!')
    end
  end

  def new_one(course, course_name)
    course.title == course_name ? true : false
  end
end
