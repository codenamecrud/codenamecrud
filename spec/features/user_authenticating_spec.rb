require 'rails_helper'

feature 'User authenticating and unauthenticating' do
  given(:user) { build(:user) }
  given(:saved_user) { create(:user) }

  scenario 'Registration' do
    visit root_path

    click_on 'Регистрация'
    fill_in 'Имя', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    click_on 'Зарегистрироваться'

    expect(page).to have_content "Привет, #{user.name}"
  end

  scenario 'Authenticating' do
    sign_in_with(saved_user.email, saved_user.password)

    visit root_path
    click_on 'Выход'

    expect(page).to have_content 'Выход из системы выполнен.'
  end

end
