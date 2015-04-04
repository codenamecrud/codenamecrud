class LessonsController < ApplicationController
  def show
    @lesson = Lesson.friendly.find(params[:id])
  end
end
