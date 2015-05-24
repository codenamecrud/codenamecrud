class PagesController < ApplicationController
  def faq
  end

  def about
  end

  def contacts
  end

  def contribute
    curriculum = open 'https://api.github.com/repos/codenamecrud/curriculum/contributors'
    codenamecrud = open 'https://api.github.com/repos/codenamecrud/codenamecrud/contributors'

    @curriculum = JSON.load(curriculum)
    @codenamecrud = JSON.load(codenamecrud)
  end
end
