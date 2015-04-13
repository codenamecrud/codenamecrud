FactoryGirl.define do
  factory :lesson do
    title "lesson"
    slug "lesson"
    description "lesson description"
    section { create(:section) }
    is_project false
  end

end
