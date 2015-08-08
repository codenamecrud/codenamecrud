require 'rails_helper';

describe 'Registration Email' do
  let(:user) { build(:user) }
  let(:mail) { UserMailer.welcome_email(user) }

  include EmailSpec::Helpers
  include EmailSpec::Matchers
  include Rails.application.routes.url_helpers

  it 'has valid email recipient' do
    expect(user.email).to match(/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  end

  skip 'able to send welcome email' do
    expect { user.send_welcome_email }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  pending 'sends email after sing up' do
    expect { sign_up_with(user.name, user.email, user.password) }.to change { User.count and ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'deliver email to user' do
    expect(mail).to deliver_to(user.email)
  end

  it 'renders the subject' do
    expect(mail).to have_subject('Добро пожаловать на Сodenamecrud.ru')
  end

  it 'renders the receiver email' do
    expect(mail.to).to eql([user.email])
  end

  it 'has: user name' do
    expect(mail.body.encoded).to match(user.name)
  end

  it 'include email content' do
    expect(mail).to have_body_text(/codenamecrud.ru/)
  end

  it 'email sender' do
    expect(mail).to deliver_from('frey@list.ru')
  end

end
