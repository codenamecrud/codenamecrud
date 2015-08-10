module Admin
  class HomeController < Admin::ApplicationController
    def index
      @courses_count = Course.count
      @sections_count = Section.count
      @lessons_count = Lesson.count
      @lessons_percent = Lesson.count*100/179
      @completed_lessons_count = LessonUser.count
      @users_count = User.count
      gon.dates = @dates = User.all.pluck(:created_at).map {|t| t.strftime('%d-%m-%Y')}
      gon.users = @users = @dates.each do |d|
        User.where("created_at > ? and created_at < ?", d.to_date.beginning_of_day, d.to_date.end_of_day)
      end
    end
  end
end
