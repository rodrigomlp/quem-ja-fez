class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def check_if_user_is_undergraduate
    # If the user is not an undergraduate he won't be able to access this page
    unless current_user.undergraduate
      # redirect_to root_path #TO-DO: criar mesagem de erro de que ele não pode entrar nessa página e depois redirecioná-lo
    end
  end
end
