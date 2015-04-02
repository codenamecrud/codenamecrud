class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def show
    @course = Course.friendly.find(params[:id])
  end
end
