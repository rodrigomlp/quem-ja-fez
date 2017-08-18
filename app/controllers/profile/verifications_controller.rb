class Profile::VerificationsController < ApplicationController
  before_action :authenticate_user!

  def show # deveria ser NEW
    @user = current_user
    @resume = Resume.new
  end

  def update # deveria ser CREATE
    @resume = Resume.new(resume_params)
    @resume.user = current_user

    # only submit form if right info is provided
    if @resume.save
      current_user.undergraduate = true;  # user is now an undergrad
      current_user.save! # save to DB

      redirect_to profile_resumes_path
    else
      render :show # else re-render form
    end
  end

  private

  def resume_params
    params.require(:resume).permit(:school_email, :course_id, :university_id)
  end
end
