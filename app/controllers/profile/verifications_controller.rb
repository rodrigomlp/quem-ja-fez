class Profile::VerificationsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @resume = Resume.new
  end

  def update
    @resume = Resume.new(resume_params)
    @resume.user = current_user

    if @resume.save
      UserMailer.validation(@resume).deliver_now # send email to validade school email
      current_user.undergraduate = true;  # user is now an undergrad
      current_user.save! # save to DB

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
