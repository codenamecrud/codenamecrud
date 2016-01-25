DisqusRails.setup do |config|
  config::SHORT_NAME = 'enfield-rookies'
  config::SECRET_KEY = ENV['DISQUS_API_KEY']
  config::PUBLIC_KEY = ENV['DISQUS_API_SECRET']
  config::ACCESS_TOKEN = ENV['DISQUS_ACCESS_TOKEN']
end
