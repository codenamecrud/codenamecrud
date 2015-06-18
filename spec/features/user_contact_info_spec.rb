require 'rails_helper';

feature 'Edit User Info' do
  given!(:user) { create(:user) }
  given!(:new_user_info) { build(:user) }

  scenario 'can update profile data' do
    sign_in_with(user.name, user.password)
    visit edit_user_registration_path(user)
    fill_in 'user_name', with: new_user_info.name
    fill_in 'user_twitter_name', with: new_user_info.twitter_name
    fill_in 'user_github_name', with: new_user_info.github_name
    fill_in 'user_current_password', with: user.password
    click_on 'Обновить'
    visit user_path(user)

    expected_to_see_updated_username
    expected_to_see_updated_github_username
    expected_to_see_updated_twitter_username
  end
end

def expected_to_see_updated_username
  expect(page).to have_content new_user_info.name
end

def expected_to_see_updated_github_username
  expect(page).to have_content new_user_info.github_name
end

def expected_to_see_updated_twitter_username
  expect(page).to have_content new_user_info.twitter_name
end
