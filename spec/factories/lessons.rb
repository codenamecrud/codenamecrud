FactoryGirl.define do
  factory :lesson do
    title 'lesson_title'
    slug 'lesson_slug'
    description 'lesson description'
    section { create(:section) }
    is_project false
  end

end
