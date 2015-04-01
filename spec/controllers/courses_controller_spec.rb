require 'rails_helper'

describe CoursesController do
  let!(:course) { create(:course) }

  describe "GET #index" do
    before { get :index }

    it "returns http success" do
      expect(response).to render_template :index
    end

    it 'assigns all courses to courses variable' do
      expect(assigns(:courses)).to eq [course]
    end
  end

  describe "GET #show" do
    before { get :show, id: course }

    it "returns http success" do
      expect(response).to render_template :show
    end

    it 'assigns course to variable' do
      expect(assigns(:course)).to eq course
    end
  end

end
