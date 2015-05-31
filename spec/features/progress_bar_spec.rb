require 'rails_helper'

feature 'Navigating between lessons' do
  given(:user) { create(:user) }
  given(:course) { create(:course) }

  given(:section1) { create(:section, course: course) }

  given!(:lesson1) { create(:lesson, course: course, section: section1) }
  given!(:lesson2) { create(:lesson, course: course, section: section1) }
  given!(:lesson3) { create(:lesson, course: course, section: section1) }



  it 'displys progress bar' do
    Capybara.ignore_hidden_elements = false
    sign_in_with(user.name, user.password)
    visit course_path(course)

    #   within ('div.col-sm-8.col-sm-offset-2') do
    #     find('div.lesson')
    #     find('div.row.bs-wizard')
    #   end
    #   expect(page).to have_css('div.progress-bar')
  end
end
