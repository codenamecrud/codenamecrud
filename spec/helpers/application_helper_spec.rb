require 'rails_helper'

describe ApplicationHelper do
  describe '#breadcrumbs' do
    it 'returns proper breadcrumbs' do
      @course = create(:course)
      @section = create(:section, course: @course)
      @lesson = create(:lesson, section: @section, course: @course)

      helper.breadcrumbs.should eq("#{link_to 'Список курсов', courses_path} >> #{link_to @lesson.course.title, course_path(@lesson.course)} >> #{link_to @lesson.section.title, course_path(@lesson.course, anchor: "section-#{@lesson.section.slug}")} >> #{@lesson.title}")
    end
  end
end
