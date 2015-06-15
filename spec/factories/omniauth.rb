FactoryGirl.define do
  factory :github_auth, class: OmniAuth::AuthHash do
    skip_create

    transient do
      id { SecureRandom.random_number(1_000_000_000).to_s }
      username 'john-doe'
      name 'Jonh Doe'
      email 'john.doe@example.com'
      token { SecureRandom.urlsafe_base64(100).delete('-_').first(100) }
      expires_at { SecureRandom.random_number(1.month).seconds.from_now }
    end

    provider 'github'
    uid { id }

    info do
      {
        nickname: username,
        email: email,
        name: name
      }
    end
  end
end
