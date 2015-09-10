require 'rails_helper'

describe Section do
  it { should belong_to(:course) }
  it { should have_many(:lessons) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:description) }

  it "#next_lesson_in_the_section should have next lesson" do
    course = FactoryGirl.create(:course, id: 1)
    section = FactoryGirl.create(:section, id: 1, course: course)
    lesson1 = FactoryGirl.create(:lesson, id: 1, course: course, section: section)
    lesson2 = FactoryGirl.create(:lesson, id: 2, course: course, section: section)

    expect(section.next_lesson_in_the_section(lesson1)).to eq(lesson2)
  end

  it "#next_lesson_in_the_section should not have next lesson" do
    course = FactoryGirl.create(:course, id: 1)
    section = FactoryGirl.create(:section, id: 1, course: course)
    section1 = FactoryGirl.create(:section, id: 2, course: course)
    lesson1 = FactoryGirl.create(:lesson, id: 1, course: course, section: section)
    lesson2 = FactoryGirl.create(:lesson, id: 2, course: course, section: section1)

    expect(section.next_lesson_in_the_section(lesson1)).to eq(nil)
  end

end
