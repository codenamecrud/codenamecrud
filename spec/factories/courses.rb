FactoryGirl.define do
  factory :course do
    sequence(:title) { |n| "Ruby #{n}" }
    description "MyText"
    active false
  end

end
