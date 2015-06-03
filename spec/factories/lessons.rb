FactoryGirl.define do
  factory :lesson do
    sequence(:title) { |n| "lesson_title#{n}" }
    slug 'lesson_slug'
    description 'lesson description'
    section { create(:section) }
    is_project false
  end

end
