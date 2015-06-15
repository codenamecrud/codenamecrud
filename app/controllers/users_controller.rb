class UsersController < ApplicationController
  def activity
    @activities = PaperTrail::Version.where(item_type: 'LessonUser')
                                     .order(created_at: :desc)
                                     .paginate(page: params[:page], per_page: 20)
  end

  def show
    @user = User.find(params[:id])
    @activities = PaperTrail::Version.where(item_type: 'LessonUser', whodunnit: @user.id.to_s)
                                     .order(created_at: :desc)
                                     .paginate(page: params[:page], per_page: 20)
  end
end
