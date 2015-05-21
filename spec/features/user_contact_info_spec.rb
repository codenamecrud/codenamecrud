require 'rails_helper';

describe 'Edit User Info' do
  let(:user) { create(:user) }
  let(:new_user_info) { build(:user) }

  before :each do
    sign_in_with(user.name, user.password)
    visit edit_user_registration_path(user)
    fill_in 'user_name', with: new_user_info.name
    fill_in 'user_twitter_name', with: new_user_info.twitter_name
    fill_in 'user_github_name', with: new_user_info.github_name
    fill_in 'user_current_password', with: user.password
    click_on 'Обновить'
    visit user_path(user)
  end

  it 'display updated user name' do
    expect(page).to have_content new_user_info.name
  end

  it 'display updated Github username' do
    expect(page).to have_content new_user_info.github_name
  end

  it 'display updated Twitter username'do
    expect(page).to have_content new_user_info.twitter_name
  end

end
