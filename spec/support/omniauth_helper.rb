# in spec/support/omniauth_macros.rb
module OmniauthHelpers
  def mock_auth_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:github] = {
      'provider' => 'github',
      'uid' => '12345',
      'info' => {
        'name' => 'natasha',
        'email' => 'hi@natashatherobot.com',
        'nickname' => 'NatashaTheRobot'
      },
        'extra' => {'raw_info' =>
          { 'location' => 'San Francisco',
            'gravatar_id' => '123456789'
          }
        }
      }
  end
end
