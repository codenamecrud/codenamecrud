require 'rails_helper'

describe User do
  let(:user) { create(:user) }

  it { should have_many(:lessons).through(:lesson_users) }

  it 'contains dafault value :true for :display_email column' do
    expect(user.display_email).to eql(true)
  end

end
