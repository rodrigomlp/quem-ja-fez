class Profile::ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_user_is_undergraduate
  before_action :set_resume, only: [:update, :destroy]
  helper_method :index, :current_class?

  def index
    @resumes = current_user.resumes
    @new_resume = Resume.new
  end

  def create
    @resume = Resume.new(resume_params)
    @resume.school_email = nil unless EmailChecker.is_valid?(@resume.school_email, @resume.university)

    @resume.user = current_user
    if @resume.save
      redirect_to profile_resumes_path
    else
      @resumes = current_user.resumes
      @new_resume = Resume.new
      render :index
    end

  end

  def update
    if @resume.email_checked
      if @resume.update(resume_params_for_checked_resume)
        redirect_to profile_resumes_path
      else
        render :index
      end
    else
      if @resume.update(resume_params)
        redirect_to profile_resumes_path
      else
        render :index
      end
      # TO-DO: fazer ação que envia check de e-mail
    end
  end


  def destroy
    @resume.destroy
    redirect_to profile_resumes_path
  end

  private

  def resume_params
    params.require(:resume).permit(:university_id, :course_id, :school_email, :relative_completion, :stance, :academic_description)
  end

  def resume_params_for_checked_resume
    params.require(:resume).permit(:relative_completion, :stance, :academic_description)
  end

  def set_resume
    @resume = Resume.find(params[:id])
  end

  def current_class?(test_path)

    if request.path == test_path
      return 'list-group-item active'
    else
      return 'list-group-item'
    end

  end
end
