require 'rails_helper';

describe 'Edit User Info' do
  let(:user) { build(:user) }
  let(:new_user_info) { build(:user) }

  before :each do
    sign_up_with(user.name, user.email, user.password)
    visit edit_user_registration_path
  end

  it 'hide email if checkbox checked' do
    check('Скрыть Email')
    fill_in 'Имя', with: new_user_info.name
    fill_in 'GitHub', with: new_user_info.github_name
    fill_in 'Twitter', with: new_user_info.twitter_name
    fill_in 'user_current_password', with: user.password
    click_on 'Обновить'
    click_on("Привет, #{new_user_info.name}")
    expect(page).not_to have_content(user.email)

  end

  it 'displays email if checkbox unchecked' do
    uncheck('Скрыть Email')
    fill_in 'Имя', with: new_user_info.name
    fill_in 'GitHub', with: new_user_info.github_name
    fill_in 'Twitter', with: new_user_info.twitter_name
    fill_in 'user_current_password', with: user.password
    click_on 'Обновить'
    click_on("Привет, #{new_user_info.name}")
    expect(page).to have_content(user.email)
  end

end
