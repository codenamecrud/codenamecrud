FactoryGirl.define do
  factory :section do
    title 'section_MyString'
    slug 'section_mystring'
    course { create(:course) }
    description 'MyText'
  end
end
