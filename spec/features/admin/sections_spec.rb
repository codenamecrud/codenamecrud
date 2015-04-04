require 'rails_helper'

feature 'Sections administration' do
  given(:section) { build(:section) }
  given!(:course) { create(:course) }

  scenario 'section creating' do
    visit admin_root_path

    click_on 'Разделы'
    click_on 'Добавить раздел'
    fill_in 'Название раздела', with: section.title
    fill_in 'Адрес раздела в URL', with: section.slug
    fill_in 'Описание', with: section.description
    select course.title, from: 'section_course_id'
    click_on 'Создать Section'

    expect(page).to have_content section.title
    expect(page).to have_content 'Раздел создан'
  end

  scenario 'section editing' do
    new_section = create(:section)
    visit admin_root_path
    click_on 'Разделы'

    click_on new_section.title

    fill_in 'Название раздела', with: 'Updated title'
    click_on 'Сохранить Section'

    within 'h2' do
      expect(page).to have_content 'Updated title'
    end
  end
end
