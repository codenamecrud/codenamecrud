require 'rails_helper'

feature 'Users activity' do
  given(:user) { create(:user) }
  given(:course) { create(:course) }
  given(:section) { create(:section, course: course) }
  given!(:lesson) { create(:lesson, course: course, section: section) }

  it 'logs on activity page', js: true do
    sign_in_with(user.email, user.password)

    visit course_path(course)
    # Нужно кликать по иконке, а не искать ссылку черех xpath
    find(:xpath, "//a[@href=\"#{current_path}/#{lesson.slug}/toggle_check\"]").click

    visit activity_users_path

    expect(page).to have_content "#{user.name} выполнил #{lesson.title} меньше 1 минуты назад"
  end
end
