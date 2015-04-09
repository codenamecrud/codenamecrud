FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "email#{n}@gmail.com" }
    password 00000000
    password_confirmation 00000000
  end

end
