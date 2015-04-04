require 'rails_helper'

feature 'Lessons administration' do
  given!(:section) { create(:section) }
  given(:lesson) { build(:lesson) }

  scenario 'lesson creating' do
    visit admin_root_path

    click_on 'Уроки'
    click_on 'Добавить урок'

    fill_in 'Название урока', with: lesson.title
    fill_in 'Адрес урока в URL', with: lesson.slug
    fill_in 'Описание', with: lesson.description
    select section.title, from: 'lesson_section_id'

    check 'Проект?'
    click_on 'Сохранить урок'

    expect(page).to have_content lesson.title
    expect(page).to have_content 'Урок создан'
    expect(page).to have_content 'Проект? true'
  end

  scenario 'lesson editing' do
    new_lesson = create(:lesson)
    visit admin_root_path
    click_on 'Уроки'

    click_on new_lesson.title

    fill_in 'Название урока', with: 'Updated title'
    click_on 'Сохранить урок'

    within 'h2' do
      expect(page).to have_content 'Updated title'
    end
    expect(page).to have_content 'Урок обновлен'
  end
end
