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

  describe '.from_omniauth' do
    subject { User.from_omniauth github_auth }

    let(:github_auth) { create :github_auth }

    context 'when user is not exists' do
      it 'creates new user' do
        expect { subject }.to change(User, :count).by 1
      end

      it "properly sets user's email" do
        user = subject
        expect(user.email).to eq github_auth.info.email
      end

      it "properly sets user's name" do
        user = subject
        expect(user.name).to eq github_auth.info.name
      end

      it "properly sets user's github_name" do
        user = subject
        expect(user.github_name).to eq github_auth.info.nickname
      end
    end

    context 'when user already exists' do
      let!(:user) { create :user, provider: 'github', uid: github_auth.uid }

      it 'does not create new user' do
        expect { subject }.not_to change(User, :count)
      end
    end
  end

  describe '#clear_provider!' do
    subject { user.clear_provider! }

    let!(:user) { create :user, provider: 'github', uid: '12345' }

    it 'clears provider' do
      expect { subject }.to change { user.provider }.to nil
    end

    it 'clears uid' do
      expect { subject }.to change { user.uid }.to nil
    end
  end

  describe '#update_omniauth_data' do
    subject { user.update_omniauth_data github_auth }

    let!(:user) { create :user }
    let(:github_auth) { create :github_auth }

    it 'updates provider' do
      expect { subject }.to change { user.provider }.to 'github'
    end

    it 'updates uid' do
      expect { subject }.to change { user.uid }.to github_auth.uid
    end

    it 'updates github_name' do
      expect { subject }
        .to change { user.github_name }
        .to github_auth.info.nickname
    end
  end
end
