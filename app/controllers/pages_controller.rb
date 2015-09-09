class PagesController < ApplicationController
  def faq
  end

  def about
  end

  def contacts
  end

  def home
    @courses = Course.find_each
  end

  def curriculum
    @courses = Course.find_each
  end

  def contribute
    curriculum = open "https://api.github.com/repos/codenamecrud/curriculum/contributors?client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}"
    codenamecrud = open "https://api.github.com/repos/codenamecrud/codenamecrud/contributors?client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}"

    @curriculum = JSON.load(curriculum)
    @codenamecrud = JSON.load(codenamecrud)

    @developers = []
    git_comments = ["https://api.github.com/repos/codenamecrud/codenamecrud/issues/comments",
                    "https://api.github.com/repos/codenamecrud/codenamecrud/pulls/comments",
                    "https://api.github.com/repos/codenamecrud/codenamecrud/comments"]

    git_comments.each do |source|
      comments = open "#{source}?client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}"
      comments_json = JSON.load(comments)

      comments_json.each do |comment|
        current_dev = comment['user']
        @developers.push(current_dev)
      end
    end

    @developers.uniq!
  end
end
