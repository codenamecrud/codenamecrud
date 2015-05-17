require 'rails_helper';

describe 'Edit User Info' do
  let(:user) { build(:user) }
  let(:new_user_info) { build(:user) }

  before :each do
    update_user_info(user, new_user_info)
    click_on("Привет, #{new_user_info.name}")
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
