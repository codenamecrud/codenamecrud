FactoryGirl.define do
  factory :lesson do
    title "MyString"
    slug "MyString"
    description "MyString"
    section { create(:section) }
    is_project false
  end

end
