class Profile::MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting, only: [:show, :edit, :update]

  # lógica ainda não terminada
  def index
    @meetings_accepted = current_user.meetings_accepted
    @meetings_proposed = current_user.meetings_proposed
    @future_meetings_accepted = @meetings_accepted.where('start_time > ?', Time.now)
    @future_meetings_proposed = @meetings_accepted.where('start_time > ?', Time.now)
    @future_meetings = @future_meetings_accepted + @future_meetings_proposed
    @future_meetings.sort! { |a, b|  a.start_time <=> b.start_time }

  end


  def show
    @undergraduate = User.find(@meeting.undergraduate_id)
    @highschooler = User.find(@meeting.undergraduate_id)
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

end
