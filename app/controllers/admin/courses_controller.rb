module Admin
  class CoursesController < ApplicationController
    before_action :set_course, only: [:show, :edit, :update, :destroy]

    def index
      @courses = Course.all
    end

    def show
    end

    def new
      @course = Course.new
    end

    def update
    end

    def destroy
      @course.destroy
      redirect_to admin_courses_path, notice: 'Курс был удален'
    end

    def create
      @course = Course.new(course_params)

      if @course.save
        redirect_to admin_course_path(@course), notice: 'Курс создан'
      else
        render :new
      end
    end

    def edit
    end

    private

    def course_params
      params.require(:course).permit(:title, :description, :active)
    end

    def set_course
      @course = Course.find(params[:id])
    end
  end
end
