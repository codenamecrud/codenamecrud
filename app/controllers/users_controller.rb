class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @activities = Activity.user_lessons(@user, params[:page])
  end
end
