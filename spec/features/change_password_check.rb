require 'rails_helper';

feature 'Check if change password function works properly' do
  given(:user) { create(:user) }
  NEW_PASSWORD = '12345678'

  scenario 'Change password in a bad way, check error message' do
    sign_in_with(user.email, user.password)    
    click_on 'Настройки'
    
    fill_in 'user_password', :with => NEW_PASSWORD
    fill_in 'user_password_confirmation', :with => "#{NEW_PASSWORD}2"
    click_on 'Обновить'
    
    expect(page).to have_content 'не совпадает с полем Новый пароль'
  end

  scenario 'Change password properly, check results' do
    sign_in_with(user.email, user.password)
    click_on 'Настройки'

    fill_in 'user_password', :with => NEW_PASSWORD
    fill_in 'user_password_confirmation', :with => NEW_PASSWORD
    fill_in 'user_current_password', :with => user.password
    click_on 'Обновить'

    sign_in_with(user.email, NEW_PASSWORD)
    
    expect(page).to have_content "Привет, #{user.name}"
  end
end
