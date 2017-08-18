class Profile::VerificationsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @resume = Resume.new
  end

  def update
    @resume = Resume.new(resume_params)
    @resume.user = current_user
    # Custom class that validades if the e-mail is from a known university or not.
    @resume.school_email = nil unless EmailChecker.is_valid?(@resume.school_email, @resume.university)

    # only submit form if right info is provided
    if @resume.save
      @resume.email_confirmation_token = SecureRandom.urlsafe_base64 # This create a randon token. More info: http://ruby-doc.org/stdlib-1.9.2/libdoc/securerandom/rdoc/SecureRandom.html
      UserMailer.validation(@resume).deliver_now # send email to validade school email
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
