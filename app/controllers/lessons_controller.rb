class LessonsController < ApplicationController
  before_action :set_lesson_and_course, only: [:show, :toggle_check]
  def show
  end

  def toggle_check
    if current_user.lessons.include? @lesson
      current_user.lessons.delete(@lesson)
    else
      current_user.lessons << @lesson
    end
  end

  private

  def set_lesson_and_course
    @lesson = Lesson.friendly.find(params[:id])
    @course = @lesson.course
  end
end
