require 'rails_helper'

feature 'User authenticating and unauthenticating' do
  given(:user) { build(:user) }

  scenario 'Registration' do
    visit root_path

    click_on 'Регистрация'
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    click_on 'Sign up'

    expect(page).to have_content "Привет, #{user.name}"
  end

end
