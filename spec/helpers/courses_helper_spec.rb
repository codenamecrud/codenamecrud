require 'rails_helper'

describe CoursesHelper do
  let!(:index) { 0 }
  describe 'Inactive courses' do
    it 'if course is unactive' do
      course = create(:course)
      expect(helper.course_link(course, index)).to eq(content_tag(:span, "#{index}: #{course.title}", data: { toggle: 'tooltip', placement: 'bottom' }, title: 'Этот курс еще не готов, но если вы оставите нам ваш email, мы пришлем вам письмо, когда он станет доступен!'))
    end
  end

  describe 'Active courses' do
    let(:course) { create(:course, is_active: true) }

    it 'if course is active' do
      expect(helper.course_link(course, index, false)).to eq(link_to "#{index}: #{course.title} ", course)
    end

    it 'shows NEW COURSE remark if it is new' do
      expect(helper.course_link(course, index, true)).to eq(link_to "#{index}: #{course.title} <span class=\"text-success\">(Новый курс!)</span>".html_safe, course)

    end
  end

end
