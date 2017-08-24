class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def show
    user = User.find(params[:id])
    @resume = Resume.find_by(user_id: user.id)
    @meetings = Meeting.where(undergraduate_id: @resume.user.id)

    count = 0

    @meetings.each do |meeting|
      if !meeting.rating.nil?
        count += meeting.rating
      end
    end

    @count_reviews = 0

    @meetings.each do |meeting|
      if meeting.review_title.nil?
        @count_reviews
      else
        @count_reviews += 1
      end
    end

    @avg_rating = (count.to_f / @meetings.size).round(2) unless @meetings.size == 0 # If user has no reviews, there is no rating yet.

  end

  def index
    # Displays this on banner form
    @university = params[:university]
    @course = params[:course]

    @resumes = Resume.all
    @resumes = @resumes.joins(:course, :university, :user) # joins all tables onto resume PERGUNTA: por que eu preciso dar join?
    @resumes = @resumes.where(email_checked: true) # only show resumes that have been verified

    if params[:university].present? # has the user entered anything in the 'university' search field?
      @resumes = @resumes.where("LOWER(universities.name) ILIKE ?", "%#{params[:university]}%") #PERGUNTA: por que o ilike e nao só like? O que é esse lower?
    end
    if params[:course].present? # has the user entered anything in the 'course' search field?
      @resumes = @resumes.where("LOWER(courses.name) ILIKE ?", "%#{params[:course]}%")
    end

    # binding.pry
  end

  def schedule

  end


end
