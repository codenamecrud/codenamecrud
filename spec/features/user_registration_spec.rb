require 'rails_helper'

feature 'Registration' do
  scenario 'can register with valid credentials' do
    visit root_path
    navigate_to_regisration_page
    fill_in_registration_form

    expect(page).to have_content successful_registration_message
  end

  scenario 'cannot register if email is in use' do
    create :user, email: 'bruce.wayne@wayne.ent'

    visit root_path
    navigate_to_regisration_page
    fill_in_registration_form

    expect_to_see_validation_error
    expect(page).not_to have_content successful_registration_message
  end
end

def navigate_to_regisration_page
  within '.navbar-right' do
    click_link 'Регистрация'
  end
end

def fill_in_registration_form
  within '#new_user' do
    fill_in 'user_name', with: 'Bruce Wayne'
    fill_in 'user_email', with: 'bruce.wayne@wayne.ent'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Зарегистрироваться'
  end
end

def successful_registration_message
  'Добро пожаловать! Вы успешно зарегистрировались.'
end

def expect_to_see_validation_error
  within('div.user_email') do
    expect(page).to have_content 'уже существует'
  end
end
