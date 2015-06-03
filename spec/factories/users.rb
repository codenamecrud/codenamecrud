FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "email#{n}@gmail.com" }
    sequence(:github_name) { |n| "git_hub#{n}user_name" }
    sequence(:twitter_name) { |n| "@#{n}twitter_username" }
    password '00000000'
    role 'user'

    trait :is_admin do
      role 'admin'
    end
  end
end
