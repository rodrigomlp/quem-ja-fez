class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def show

  end

  def index
    @users = User.all

    @users = @users.joins(resumes: [:course, :university])
    if params[:school].present?
      @users = @users.where("LOWER(universities.name) LIKE ?", "%#{params[:school].downcase}%")
    end

    if params[:course].present?
      @users = @users.where("LOWER(courses.name) ILIKE ?", "%#{params[:course]}%")
    end

    # SELECT * FROM users
    #   JOIN resumes ON resumes.user_id = users.id
    #   JOIN courses ON resumes.course_id = courses.id
    #   JOIN universities ON resumes.university_id = universities.id
    #   WHERE courses.name LIKE "%direito%" AND
    #     universities.name LIKE "%PUC%"

  end
end
