class RegistrationsController < Devise::RegistrationsController

  def update
    @user = current_user

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(safe_params)
    else
      params[:user].delete(:current_password)
      @user.update_without_password(safe_params)
    end

    if successfully_updated
      set_flash_message :notice, :updated
      redirect_to after_update_path_for(@user)
    else
      render 'edit'
    end
  end

  def cancel_oauth
    current_user.clear_provider!
    redirect_to :back
  end

  def needs_password?(user, params) 
    params[:user][:password].present?
  end

  private

  def safe_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end
end
