class Profile::VerificationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    @resume = Resume.new
  end

  def create
    @resume = Resume.new(resume_params)
    @resume.user = current_user
    # Custom class that validades if the e-mail is from a known university or not.
    @resume.school_email = nil unless EmailChecker.is_valid?(@resume.school_email, @resume.university)

    # Only submit form if right info is provided
    if @resume.save
      # After creating this resume, an e-mail of confirmation is sent. Logic is in Resume model.
      redirect_to profile_resumes_path #TO-DO: checkque seu e-mail para validar
    else
      render :new # else re-render form
    end
  end

  def email_confirmation
    token = params[:token] # Takes token from url
    tokens_resume = Resume.find_by(email_confirmation_token: token) # Find resume relative to that token
    tokens_user = tokens_resume.user # find user relative to that token
    if tokens_user == current_user
      tokens_user.undergraduate = true  # user is now an undergrad
      tokens_user.save! # save to DB
      tokens_resume.email_checked = true # Resume is now checked
      tokens_resume.save! # Save to DB
      # TO-DO: show a messagem indicating that the e-mail was verified
      redirect_to profile_resumes_path
    else
      # TO-DO: Show a message indicating that somenthing went wrong redirect to home
      redirect_to root_path
    end
  end

  private

  def resume_params
    params.require(:resume).permit(:school_email, :course_id, :university_id)
  end

end
