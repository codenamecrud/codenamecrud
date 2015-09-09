require 'rails_helper'

describe CoursesHelper do
  it "if course is unactive" do
    course = FactoryGirl.create(:course)
    index = 0
    expect(helper.course_link(course, index)).to eq(content_tag(:span, "#{index}: #{course.title}", data: { toggle: 'tooltip', placement: 'bottom' }, title: 'Этот курс еще не готов, но если вы оставите нам ваш email, мы пришлем вам письмо, когда он станет доступен!'))
  end

  it "if course is active" do
    course = FactoryGirl.create(:course, is_active: true)
    index = 0
    expect(helper.course_link(course, index)).to eq(link_to "#{index}: #{course.title}", course)
  end

end
