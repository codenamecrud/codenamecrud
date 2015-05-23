class UsersController < ApplicationController
  def activity
    @activities = PaperTrail::Version.where(item_type: 'LessonUser')
                                     .order(created_at: :desc)
                                     .paginator(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @activities = PaperTrail::Version.where(item_type: 'LessonUser', whodunnit: @user.id.to_s)
                                     .order(created_at: :desc)
                                     .paginator(params[:page])
  end

end
