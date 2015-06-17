namespace :sitemap do
  desc "Generate sitemaps and ping search engines (+yandex)."
  task :custom_refresh => ['sitemap:create'] do
    SitemapGenerator::Sitemap.ping_search_engines(
      yandex: 'https://blogs.yandex.ru/pings/?status=success&url=%s'
    )
  end
end
