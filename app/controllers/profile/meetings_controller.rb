class Profile::MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting, only: [:show, :edit, :update]
  helper_method :index, :current_class?
  helper_method :update, :current_class?
  helper_method :new, :current_class?
  helper_method :edit, :current_class?
  helper_method :show, :current_class?

  # lógica ainda não terminada
  def index
    @meetings_accepted = current_user.meetings_accepted
    @meetings_proposed = current_user.meetings_proposed
    # Future meetings
    @future_meetings_accepted = @meetings_accepted.where('start_time > ?', Time.now)
    @future_meetings_proposed = @meetings_proposed.where('start_time > ?', Time.now)
    @future_meetings = @future_meetings_accepted + @future_meetings_proposed
    @future_meetings.sort! { |a, b|  a.start_time <=> b.start_time }
    # Past meetings
    @past_meetings_accepted = @meetings_accepted.where('start_time < ?', Time.now)
    @past_meetings_proposed = @meetings_proposed.where('start_time < ?', Time.now)
    @past_meetings = @past_meetings_accepted + @past_meetings_proposed
    @past_meetings.sort! { |a, b|  a.start_time <=> b.start_time }
    # All the meetings together
    @meetings = @future_meetings + @past_meetings
  end


  def show
    if current_user.id == @meeting.highschooler.id
      @name = @meeting.undergraduate.first_name
    else
      @name = @meeting.highschooler.first_name
    end

    @diff = ((@meeting.end_time - @meeting.start_time) / 60).round

    @university = @meeting.university_name
    @course = @meeting.course_name

  end

  def new
    @meeting = Meeting.new
  end

  def update
    if @meeting.update(meeting_params)
      redirect_to profile_meeting_path(@meeting)
    else
      render :show
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:review_title, :review_content)
  end

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def current_class?(test_path)

    if (request.path == test_path) || (request.path == "#{test_path}/#{params[:id]}")
      return 'list-group-item active'
    else
      return 'list-group-item'
    end

  end

end
