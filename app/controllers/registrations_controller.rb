class RegistrationsController < Devise::RegistrationsController

  def update
    @user = current_user

    if update_password
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
  
  def needs_password?
    params[:user][:password].present?
  end
  
  def update_password
    return @user.update_with_password(safe_params) if needs_password?
    params[:user].delete(:current_password)
    @user.update_without_password(safe_params)
  end

  def safe_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end
end
