require 'rails_helper'

feature 'Reset password' do
  given(:user) { create(:user) }

  %i[name email].each do |login|
    scenario "User resets password using his #{login}" do
      visit new_user_password_path

      within '#new_user' do
        fill_in 'Имя пользователя или email', with: user.send(login)
        click_on 'Отправить мне инструкции'
      end

      expect(current_path).to eq new_user_session_path
      expect(page).to have_content I18n.t('devise.passwords.send_instructions')
    end
  end
end
