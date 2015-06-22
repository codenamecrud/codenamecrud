class ActivityController < ApplicationController
  def show
    @activities = Activity.user_lessons(params[:page])
  end
end
