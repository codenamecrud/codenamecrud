module Admin
  class LessonsController < ApplicationController
    before_action :set_lesson, only: [:show, :edit, :update, :destroy]

    def index
      @lessons = Lesson.all
    end

    def show
    end

    def new
      @lesson = Lesson.new
    end

    def update
      if @lesson.update(lesson_params)
        redirect_to [:admin, @lesson], notice: 'Урок обновлен'
      else
        render :edit
      end
    end

    def destroy
      @lesson.destroy
      redirect_to admin_lessons_path, notice: 'Урок удален'
    end

    def create
      @lesson = Lesson.new(lesson_params)

      if @lesson.save
        redirect_to admin_lesson_path(@lesson), notice: 'Урок создан'
      else
        render :new
      end
    end

    def edit
    end

    private

    def lesson_params
      params.require(:lesson).permit(:title, :description, :slug, :section_id, :is_project)
    end

    def set_lesson
      @lesson = Lesson.friendly.find(params[:id])
    end
  end
end
