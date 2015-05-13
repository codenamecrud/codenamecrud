module UsersHelpers

  def sign_up_with(name, email, password)
    visit new_user_registration_path

    fill_in 'Имя', with: name
    fill_in 'Email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password

    click_button 'Зарегистрироваться'
  end

  def sign_in_with(email, password)
    visit new_user_session_path

    fill_in 'Имя пользователя или email', with: email
    fill_in 'Пароль', with: password

    click_on 'Войти'
  end
end
