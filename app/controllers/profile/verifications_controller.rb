class Profile::VerificationsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @resume = Resume.new
  end

  def update
    @resume = Resume.new(resume_params)
    @resume.user = current_user
    current_user.undergraduate = true; #set user to be an undergrad
    @resume.save!
    # TO-DO: University must exist, Course must exist
  end

  private

  def resume_params
    params.require(:resume).permit(:school_email)
  end
end
