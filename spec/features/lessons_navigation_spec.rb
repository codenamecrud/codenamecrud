require 'rails_helper'

feature 'Navigating between lessons' do
  given(:user) { create(:user) }
  given(:course) { create(:course) }

  given(:section1) { create(:section, course: course) }

  given!(:lesson1) { create(:lesson, course: course, section: section1, position: 1) }
  given!(:lesson2) { create(:lesson, course: course, section: section1, position: 4) }
  given!(:lesson3) { create(:lesson, course: course, section: section1, position: 3) }
  given!(:lesson4) { create(:lesson, course: course, section: section1, position: 2) }

  it 'on the first lesson page, displays a link only to the next lesson' do
    visit course_lesson_path(course.id, lesson1.id)
    find_link('Следующий урок').visible?
    expect(page).to_not have_content('Предыдущий урок')
  end

  it 'on the next page has a links - to the previous and next lessons' do
    visit course_lesson_path(course.id, lesson4.id)
    find_link('Предыдущий урок').visible?
    find_link('Следующий урок').visible?
  end

  it 'does not have a link to next lesson on the last lesson page' do
    visit course_lesson_path(course.id, lesson2.id)
    find_link('Предыдущий урок').visible?
    expect(page).to_not have_content('Следующий урок')
  end

  it 'has a link "Следующий урок" that navigats to the next lesson' do
    visit course_lesson_path(course.id, lesson1.id)
    page.click_link('Следующий урок')
    expect(current_path).to eql("/#{course.slug}/#{lesson2.slug}")
  end

  it 'has a link "Предыдущий урок" that navigates to the previous lesson' do
    visit course_lesson_path(course.id, lesson2.id)
    page.click_link('Предыдущий урок')
    expect(current_path).to eql("/#{course.slug}/#{lesson1.slug}")
  end

  it 'uses slugs to build valid lessons urls' do
    visit "/#{course.slug}/#{lesson1.slug}"
    expect(page.current_path).to eql("/#{course.slug}/#{lesson1.slug}")
    visit "/#{course.slug}/#{lesson2.slug}"
    expect(page.current_path).to eql("/#{course.slug}/#{lesson2.slug}")
    visit "/#{course.slug}/#{lesson3.slug}"
    expect(page.current_path).to eql("/#{course.slug}/#{lesson3.slug}")
  end
end
