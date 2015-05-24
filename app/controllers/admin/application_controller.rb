module Admin
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    layout 'admin'

    before_action :redirect_users

    private

    def redirect_users
      redirect_to root_path, notice: 'Доступ запрещен' unless current_user && current_user.admin?
    end
  end
end
