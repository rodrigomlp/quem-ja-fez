class Profile::InfosController < ApplicationController
  helper_method :edit, :current_class?
  helper_method :update, :current_class?

  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      redirect_to edit_profile_info_path # TO-DO: redirect user to another page later, maybe?
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :gender, :birth_date, :city, :country, :photo, :photo_cache)
  end

  def current_class?(test_path)

    if request.path == test_path
      return 'list-group-item active'
    else
      return 'list-group-item'
    end

  end
end
