# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://codenamecrud.ru"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  [
    pages_faq_path,
    pages_about_path,
    pages_contacts_path,
    pages_contribute_path
    pages_donate_path
    pages_curriculum_path
  ].each { |page| add page }

  Course.find_each do |course|
    add course_path(course), lastmod: course.updated_at
  end

  Lesson.find_each do |lesson|
    add course_lesson_path(lesson.course, lesson), lastmod: lesson.updated_at
  end
end
