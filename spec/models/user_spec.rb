require 'rails_helper'

describe User do
  let(:user) { create(:user) }

  it { should have_many(:lessons).through(:lesson_users) }

  it 'has dafault value :false for :display_email column' do
    expect(user.display_email).to eql(false)
  end

end
