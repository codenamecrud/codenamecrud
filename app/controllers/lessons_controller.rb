class LessonsController < ApplicationController
  def show
    @lesson = Lesson.friendly.find(params[:id])
    @course = @lesson.course
  end

  def mark_as_completed
    @lesson = Lesson.friendly.find(params[:id])
    @course = @lesson.course
    if current_user.lessons.include? @lesson
      current_user.lessons.delete(@lesson)
    else
      current_user.lessons << @lesson
    end
  end
end
