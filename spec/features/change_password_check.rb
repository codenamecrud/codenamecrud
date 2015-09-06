require 'rails_helper';

feature 'User authenticating and unauthenticating' do
  given(:user) { build(:user) }
  given(:saved_user) { create(:user) }

  scenario 'Registration and try to change password in a bad way' do
    visit root_path

    click_on 'Регистрация'
    fill_in 'Имя', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    click_on 'Зарегистрироваться'

    expect(page).to have_content "Привет, #{user.name}"

    click_on 'Настройки'

    expect(page).to have_content 'Редактирование пользователя'

    fill_in 'user_password', :with => '12345678'
    fill_in 'user_password_confirmation', :with => '87654321'
    click_on 'Обновить'
    
    expect(page).to have_content 'не совпадает с полем Новый пароль'
  end
end