FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "email#{n}@gmail.com" }
    sequence(:github_name) { |n| "git_hub#{n}user_name" }
    sequence(:twitter_name) { |n| "@#{n}twitter_username" }
    password 00000000
    password_confirmation 00000000
    role 'user'
  end

  factory :admin do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "email#{n}@gmail.com" }
    sequence(:github_name) { |n| "git_hub#{n}user_name" }
    sequence(:twitter_name) { |n| "@#{n}twitter_username" }
    password 00000000
    password_confirmation 00000000
    role 'user'
  end

end
