require 'rails_helper'

feature 'View lesson page' do
  context 'when there are lessons with same slug' do
    given!(:webdev) { create :course, title: 'Web Dev' }
    given!(:ruby) { create :course, title: 'Ruby' }

    background do
      web_section = create :section, title: 'Web Section', course: webdev
      ruby_section = create :section, title: 'Ruby Section', course: ruby
      create :lesson, course: webdev, section: web_section,
                      slug: 'conclusion', title: 'Conclusion'
      create :lesson, course: ruby, section: ruby_section,
                      slug: 'conclusion', title: 'Conclusion'
    end

    scenario 'can visit Web Dev Conclusion lesson' do
      visit course_lesson_path(webdev.slug, 'conclusion')

      within 'ol.breadcrumb' do
        expect(page).to have_content 'Web DevWeb SectionConclusion'
      end
    end

    scenario 'can visit Ruby Conclusion lesson' do
      visit course_lesson_path(ruby.slug, 'conclusion')

      within 'ol.breadcrumb' do
        expect(page).to have_content 'RubyRuby SectionConclusion'
      end
    end
  end
end
