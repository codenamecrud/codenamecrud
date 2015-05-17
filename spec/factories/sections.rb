FactoryGirl.define do
  factory :section do
    title 'MyString'
    slug 'mystring'
    course { create(:course) }
    description 'MyText'
  end

end
