require 'rails_helper'

describe RegistrationsController do

  login_user

  it "have a current_user" do
    expect(subject.current_user).not_to be_nil
  end

  it 'renders user info input form' do
    get :edit
    expect(response).to render_template(:edit)
  end
end
