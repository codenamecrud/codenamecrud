require 'rails_helper'

feature 'Activity' do
  given!(:user1) { create :user }
  given!(:user2) { create :user }
  given!(:lesson1) { create :lesson }
  given!(:lesson2) { create :lesson }

  before do
    lesson_user1 = create :lesson_user, user: user1, lesson: lesson1
    PaperTrail::Version.where(item: lesson_user1).last
      .update_column :whodunnit, user1.id.to_s

    lesson_user2 = create :lesson_user, user: user2, lesson: lesson2
    PaperTrail::Version.where(item: lesson_user2).last
      .update_column :whodunnit, user2.id.to_s
  end

  context 'when checking activity of all users' do
    scenario "everybody can see users' activity" do
      visit activity_users_path

      expect(page).to have_content user_completed_lesson(user1, lesson1)
      expect(page).to have_content user_completed_lesson(user2, lesson2)
    end
  end

  context 'when checking activity of single user' do
    scenario "everybody can see user's activity" do
      visit user_path(user1)

      expect(page).to have_content user_completed_lesson(user1, lesson1)
      expect(page).not_to have_content user_completed_lesson(user2, lesson2)
    end
  end
end

def user_completed_lesson(user, lesson)
  "#{user.name} выполнил #{lesson.title} меньше 1 минуты назад"
end
