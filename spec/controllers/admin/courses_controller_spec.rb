require 'rails_helper'

describe Admin::CoursesController do
  let!(:course) { create(:course) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status :success
      expect(response).to render_template :index
    end

    it "assigns all courses" do
      get :index
      expect(assigns(:courses)).to eq [course]
    end
  end

  describe "GET #show" do
    before { get :show, id: course }

    it "renders appropriate template" do
      expect(response).to render_template :show
    end

    it 'assigns course variable' do
      expect(assigns(:course)).to eq course
    end
  end

  describe "GET #edit" do
    before { get :edit, id: course }

    it "renders appropriate template" do
      expect(response).to render_template :edit
    end

    it 'assigns course variable' do
      expect(assigns(:course)).to eq course
    end
  end

  describe "GET #new" do
    before { get :new }

    it "renders appropriate template" do
      expect(response).to render_template :new
    end

    it 'assigns to new variable' do
      expect(assigns(:course)).to be_a_new Course
    end
  end

  describe "PATCH #update" do
  end

  describe "DELETE #destroy" do
    it 'properly destroys our course' do
      expect { delete :destroy, id: course }.to change(Course, :count).by -1
    end

    it 'redirects to course list' do
      delete :destroy, id: course
      expect(response).to redirect_to admin_courses_path
    end
  end

  describe "POST #create" do
    it 'creates course' do
      expect { post :create, course: attributes_for(:course) }.to change(Course, :count).by 1
    end

    it 'redirects to created course' do
      post :create, course: attributes_for(:course)
      expect(response).to redirect_to admin_course_path(Course.last)
    end

    pending 'with invald data'
  end

end
