class RegistrationsController < Devise::RegistrationsController

  def update
    @user = User.find(current_user.id)

    if @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
      set_flash_message :notice, :updated
      redirect_to after_update_path_for(@user)
    else
      render 'edit'
    end
  end

end
