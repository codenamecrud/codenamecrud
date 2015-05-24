require 'rails_helper'

describe User do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :is_admin) }

  it { should have_many(:lessons).through(:lesson_users) }

  it 'has dafault value :false for :display_email column' do
    expect(user.display_email).to eql(false)
  end

  it 'user? should return true if user is user' do
    expect(user.user?).to be true
  end

  it 'admin? should return true if user is admin' do
    expect(admin.admin?).to be true
  end
end
