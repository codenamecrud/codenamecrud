class UsersController < ApplicationController
  def activity
    @activities = PaperTrail::Version.where(item_type: 'LessonUser').paginate(page: params[:page], per_page: 20)
  end
end
