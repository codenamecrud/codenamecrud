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

  describe 'methods for lesson' do
    let!(:user) { FactoryGirl.create(:user) }
    let(:user2) { FactoryGirl.create(:user) }
    let!(:course) { FactoryGirl.create(:course) }
    let!(:section) { FactoryGirl.create(:section, course: course) }
    let!(:lesson1) { FactoryGirl.create(:lesson, course: course, section: section, position: 1) }
    let!(:lesson2) { FactoryGirl.create(:lesson, course: course, section: section, position: 2) }
    let!(:lesson3) { FactoryGirl.create(:lesson, course: course, section: section, position: 3) }
    let!(:lesson4) { FactoryGirl.create(:lesson, course: course, section: section, position: 4) }
    let!(:lesson5) { FactoryGirl.create(:lesson, course: course, section: section, position: 5) }
    let!(:lesson_user1) { FactoryGirl.create(:lesson_user, lesson_id: lesson1.id, user_id: user.id, completed: true, lesson: lesson1) }
    let!(:lesson_user2) { FactoryGirl.create(:lesson_user, lesson_id: lesson2.id, user_id: user.id, completed: true, lesson: lesson2) }
    let!(:lesson_user3) { FactoryGirl.create(:lesson_user, lesson_id: lesson3.id, user_id: user2.id, completed: true, lesson: lesson3) }
    let!(:lesson_user4) { FactoryGirl.create(:lesson_user, lesson_id: lesson4.id, user_id: user.id, completed: true, lesson: lesson4) }
    let!(:lesson_user5) { FactoryGirl.create(:lesson_user, lesson_id: lesson5.id, user_id: user.id, completed: true, lesson: lesson5) }

    describe '#current_lesson' do
      it 'should equal lesson in section for id this lesson' do
        expect(user.current_lesson(lesson5.id)).to eq(lesson5)
      end

      it "shouldn't equal lesson in section for id other lesson" do
        expect(user.current_lesson(lesson4.id)).to_not eq(lesson5)
      end
    end

    describe '#next_lesson' do
      it 'should have next lesson' do
        expect(user.next_lesson(lesson1)).to eq(lesson2)
      end

      it "shouldn't have next lesson" do
        expect(user.next_lesson(lesson5)).to eq(nil)
      end
    end

    describe '#last_lesson' do
      it 'last leseon should be equal lesson 5' do
        expect(user.last_lesson(section.id)).to eq(lesson5)
      end

      it "last leseon shouldn't be equal lesson 3" do
        expect(user.last_lesson(section.id)).to_not eq(lesson3)
      end
    end

    describe '#lessons_length' do
      it 'should length == 1' do
        expect(user.lessons_length(lesson1)).to eq(1)
        expect(user.lessons_length(lesson2)).to eq(1)
        expect(user2.lessons_length(lesson3)).to eq(1)
      end

      it 'should length == 0' do
        expect(user.lessons_length(lesson3)).to eq(0)
        expect(user2.lessons_length(lesson1)).to eq(0)
      end
    end
  end
end
