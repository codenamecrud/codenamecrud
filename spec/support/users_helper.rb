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

  def update_user_info(user, new_user_info)

    sign_up_with(user.name, user.email, user.password)
    visit edit_user_registration_path
    fill_in 'Имя', with: new_user_info.name
    fill_in 'Email', with: new_user_info.email
    fill_in 'GitHub', with: new_user_info.github_name
    fill_in 'Twitter', with: new_user_info.twitter_name
    fill_in 'user_current_password', with: user.password

    click_on 'Обновить'
  end

end
