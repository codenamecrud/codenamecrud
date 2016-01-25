module Admin
  class HomeController < Admin::ApplicationController
    def index
      @courses_count = Course.count
      @sections_count = Section.count
      @lessons_count = Lesson.count
      @lessons_percent = Lesson.count * 100 / 179
      @completed_lessons_count = LessonUser.count
      @users_count = User.count
    end
  end
end
