require 'rails_helper'

describe Section do
  it { should belong_to(:course) }
  it { should have_many(:lessons) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:description) }

  it "#next_lesson_in_the_section should have next lesson" do
    lesson1 = FactoryGirl.create(:lesson, id: 1, course_id: 1, section_id: 1)
    lesson2 = FactoryGirl.create(:lesson, id: 2, course_id: 1, section_id: 1)
    course = FactoryGirl.create(:course, id: 1)
    section = FactoryGirl.create(:section, id: 1, course: course)

    expect(section.next_lesson_in_the_section(lesson1)).to eq(lesson2)
  end

  it "#next_lesson_in_the_section should not have next lesson" do
    lesson1 = FactoryGirl.create(:lesson, id: 1, course_id: 1, section_id: 1)
    lesson2 = FactoryGirl.create(:lesson, id: 2, course_id: 1, section_id: 2)
    course = FactoryGirl.create(:course, id: 1)
    section = FactoryGirl.create(:section, id: 1, course: course)

    expect(section.next_lesson_in_the_section(lesson1)).to eq(nil)
  end

end
