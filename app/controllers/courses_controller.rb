class CoursesController < ApplicationController
  def show
    @course = Course.friendly.find(params[:id])
  end
end
