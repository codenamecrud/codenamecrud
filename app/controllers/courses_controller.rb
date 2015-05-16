class CoursesController < ApplicationController
  def index
    @courses = Course.find_each
  end

  def show
    @course = Course.friendly.find(params[:id])
  end
end
