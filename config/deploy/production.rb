set :stage, :production

# Replace 127.0.0.1 with your server's IP address!
server '51.15.55.249', user: 'deploy', roles: %w{web app}
