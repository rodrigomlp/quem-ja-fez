class Profile::VerificationsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @resume = Resume.new
  end

  def update
    @resume = Resume.new(resume_params)
    @resume.user = current_user
    current_user.undergraduate = true;  #set user to be an undergrad
    current_user.save! # save to DB

    if @resume.save
      redirect_to profile_resumes_path
    else
      render :show
    end
  end

  private

  def resume_params
    params.require(:resume).permit(:school_email, :course_id, :university_id)
  end
end
