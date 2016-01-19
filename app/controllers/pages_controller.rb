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

    git_comments_sources = ["https://api.github.com/repos/codenamecrud/codenamecrud/issues/comments",
                            "https://api.github.com/repos/codenamecrud/codenamecrud/pulls/comments",
                            "https://api.github.com/repos/codenamecrud/codenamecrud/comments"]

    git_comments_sources.each do |source|
      page = 1
      keep_going = true

      while keep_going
        comments = open "#{source}?page=#{page}&client_id=#{ENV['GITHUB_KEY']}&client_secret=#{ENV['GITHUB_SECRET']}"
        comments_json = JSON.load(comments)

        if comments_json.length > 0
          comments_json.each do |comment|
            current_dev = comment['user']
            @developers.push(current_dev)
          end
          page += 1
        else
          keep_going = false
        end
      end
    end

    @developers.uniq!
  end
end
