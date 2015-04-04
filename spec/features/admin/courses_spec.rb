require 'rails_helper'

feature 'Courses administration' do
  given(:course) { build(:course) }

  scenario 'course creating' do
    visit admin_root_path

    click_on 'Курсы'
    click_on 'Добавить курс'

    fill_in 'Название курса', with: course.title
    fill_in 'Адрес курса в URL', with: course.slug
    fill_in 'Короткое описание', with: course.short_description
    fill_in 'Описание', with: course.description
    check 'Опубликован?'
    click_on 'Создать Course'

    expect(page).to have_content course.title
    expect(page).to have_content 'Опубликован? true'
  end
end
