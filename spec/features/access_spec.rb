require 'rails_helper'

feature 'Admin dashboard' do
  given(:user) { create(:user) }

  it 'User have not access to dashboard' do
    sign_in_with(user.email, user.password)

    visit admin_root_path

    expect(page).to have_content 'Доступ запрещен'
  end
end
