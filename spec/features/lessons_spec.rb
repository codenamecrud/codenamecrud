require 'rails_helper'

feature 'Completing lessons' do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:course) { create(:course) }
  given(:section) { create(:section, course: course) }
  given!(:lesson) { create(:lesson, course: course, section: section) }

  # Тест зеленый, но почему-то не проходит на Codeship: http://take.ms/4H1Qt
  pending 'User can mark lesson as completed and it does not affect another user', js: true do
    sign_in_with(user.email, user.password)

    visit course_path(course)
    find(:xpath, "//a[@href=\"#{current_path}/#{lesson.slug}/toggle_check\"]").click

    expect(page).to have_selector('.mark-as-uncompleted')
    expect(user.lessons.include? lesson).to be_truthy

    click_on 'Выход'

    sign_in_with(another_user.email, another_user.password)
    expect(another_user.lessons.include? lesson).to be_falsey

    visit course_path(course)
    find('.mark-as-completed').click

    expect(page).to have_selector('.mark-as-uncompleted')
    expect(another_user.lessons.include? lesson).to be_truthy
  end

end
