module Admin
  class SectionsController < ApplicationController
    before_action :set_section, only: [:show, :edit, :update, :destroy]

    def index
      @sections = Section.all
    end

    def show
    end

    def new
      @section = Section.new
    end

    def update
      if @section.update(section_params)
        redirect_to [:admin, @section], notice: 'Раздел обновлен'
      else
        render :edit
      end
    end

    def destroy
      @section.destroy
      redirect_to admin_sections_path, notice: 'Раздел удален'
    end

    def create
      @section = Section.new(section_params)

      if @section.save
        redirect_to admin_section_path(@section), notice: 'Раздел создан'
      else
        render :new
      end
    end

    def edit
    end

    private

    def section_params
      params.require(:section).permit(:title, :description, :slug, :course_id)
    end

    def set_section
      @section = Section.friendly.find(params[:id])
    end
  end
end
