FactoryGirl.define do
  factory :lesson do
    sequence(:title) { |n| "lesson_title#{n}" }
    slug 'lesson_slug'
    description 'lesson description'
    section
    course
    is_project false
  end
end
