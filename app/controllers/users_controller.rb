class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def show
    user = User.find(params[:id])
    @resume = Resume.find_by(user_id: user.id)

    @meetings = Meeting.where(undergraduate_id: @resume.user.id)

    count = 0

    @meetings.each do |meeting|
      count += meeting.rating
    end

    @avg_rating = (count / @meetings.size) unless @meetings.size == 0 # If user has no reviews, there is no rating yet.
  end

  def index
    @resumes = Resume.all
    @resumes = @resumes.joins(:course, :university, :user) # joins all tables onto resume
    @resumes = @resumes.where(email_checked: true) # only show resumes that have been verified

    if params[:university].present? # has the user entered anything in the 'university' search field?
      @resumes = @resumes.where("LOWER(universities.name) ILIKE ?", "%#{params[:university]}%")
    end
    if params[:course].present? # has the user entered anything in the 'course' search field?
      @resumes = @resumes.where("LOWER(courses.name) ILIKE ?", "%#{params[:course]}%")
    end
  end
end
