class RegistrationsController < Devise::RegistrationsController

  def update
    @user = current_user

    if @user.update_without_password(safe_params)
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

  private

  def safe_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end
end
