class LessonsController < ApplicationController
  def show
    @lesson = Lesson.friendly.find(params[:id])
    @course = @lesson.course
  end
end
