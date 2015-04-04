class SectionsController < ApplicationController
  def show
    @course = Course.friendly.find(params[:course_id])
    @section = Section.friendly.find(params[:id])
  end
end
