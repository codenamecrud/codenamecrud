require 'rails_helper'

feature 'Progress bar' do
  given(:user) { create(:user) }
  given(:course) { create(:course, is_active: true) }
  given(:section1) { create(:section, course: course) }
  given!(:lesson1) { create(:lesson, course: course, section: section1) }
  given!(:lesson2) { create(:lesson, course: course, section: section1) }
  given!(:lesson3) { create(:lesson, course: course, section: section1) }
  given!(:lesson4) { create(:lesson, course: course, section: section1) }

  it 'does not disply progress bar if user not signed in' do
    visit course_lesson_path(course, lesson1)
    expect(page).to_not have_css('div.progress-bar')
  end

  it 'displys progress bar if user signed in' do
    sign_in_with(user.name, user.password)
    visit course_lesson_path(course.id, lesson1.id)
    expect(page.find('div.row.bs-wizard')).to have_css('div.progress-bar')
    expect(page).to have_css('div.progress-bar')
  end

  it 'displys as default no progress to all course lessons' do
    sign_in_with(user.name, user.password)
    course.lessons.each do |lesson|
      visit course_lesson_path(course.id, lesson.id)
      within('div.row.bs-wizard') do
        expect(page).to have_css('div.col-xs-1.bs-wizard-step.disabled', count: course.lessons.count)
        expect(page).to_not have_css('div.col-xs-1.bs-wizard-step.complete')
        expect(first('div.bs-wizard-info.text-center')).to_not have_content('%')
      end
    end
    expect(page).to have_css('div.progress-bar')
  end

  pending it 'displays 100% of progress if all lessons added', js: true do
    sign_in_with(user.name, user.password)
    visit course_lesson_path(course, lesson1.id)
    page.execute_script('$("a.mark-as-completed").click()')
    visit course_lesson_path(course.id, lesson2.id)
    page.execute_script('$("a.mark-as-completed").click()')
    visit course_lesson_path(course.id, lesson3.id)
    within('div.row.bs-wizard') do
      expect(page).to have_css('div.col-xs-1.bs-wizard-step.complete', count: 4)
      expect(first('div.bs-wizard-info.text-center')).to have_content('100%')
      expect(first('div.bs-wizard-info.text-center')).to have_content("#{user.completed_lessons(section1).to_i}%")
      expect(page).to have_css('div.col-xs-1.bs-wizard-step.disabled', count: 0)
    end
  end

  it 'reduces progress if user remove lesson', js: true do
    sign_in_with(user.name, user.password)
    visit course_lesson_path(course.id, lesson1.id)
    page.execute_script('$("a.mark-as-completed").click()')
    visit course_lesson_path(course.id, lesson1.id)
    page.execute_script('$("a.mark-as-uncompleted").click()')
    visit course_lesson_path(course.id, lesson3.id)
    within('div.row.bs-wizard') do
      expect(page).to have_css('div.col-xs-1.bs-wizard-step.complete', count: 0)
      expect(first('div.bs-wizard-info.text-center')).not_to have_content('25%')
      expect(first('div.bs-wizard-info.text-center')).not_to have_content("#{user.completed_lessons(section1).to_i}%")
      expect(page).to have_css('div.col-xs-1.bs-wizard-step.disabled', count: course.lessons.count)
    end
  end

  it 'displays lesson title as a link to the lesson' do
    sign_in_with(user.name, user.password)
    visit course_lesson_path(course.id, lesson1.id)
    all_progress_dots = page.all('.bs-wizard-dot')
    all_progress_dots.each do |dot|
      dot_title = dot['title']
      lesson_title = course.lessons.find_by(title: dot_title).title
      expect(dot['title']).to have_content(lesson_title)
    end
  end

  it 'Calculates and displays progress of course', js: true do
    sign_in_with(user.name, user.password)
    visit course_lesson_path(course, lesson1.id)
    page.execute_script('$("a.mark-as-completed").click()')
    visit course_path(course)
    expect(page).to have_content("#{user.completed_lessons(course).to_i}%")
  end

  pending 'displays lesson title when mouse over link' do
    sign_in_with(user.name, user.password)
    visit course_lesson_path(course.id, lesson1.id)
    all_progress_dots = page.all('.bs-wizard-dot')
    all_progress_dots.each do |dot|
      dot_title = dot['title']
      expect(dot.trigger(:mouseover)).to have_content(dot_title)
    end
  end
end
