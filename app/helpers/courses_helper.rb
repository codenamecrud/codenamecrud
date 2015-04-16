module CoursesHelper
  def course_link(course, index)
    if course.is_active?
      link_to "#{index}: #{course.title}", course
    else
      "#{index}: #{course.title}"
    end
  end
end
