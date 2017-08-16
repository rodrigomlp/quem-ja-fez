class Profile::ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_user_is_undergraduate

  def index
    @resumes = current_user.resumes
    @new_resume = Resume.new
  end

  def create
    @resume = Resume.new(resume_params)
    @resume.user = current_user
    if @resume.save
      redirect_to profile_resumes_path
    else
      render :index
    end

  end

  def update

  end

  def destroy

  end

  private

  def resume_params
    params.require(:resume).permit(:university_id, :course_id, :school_email, :relative_completion, :stance, :academic_description)
  end
end
