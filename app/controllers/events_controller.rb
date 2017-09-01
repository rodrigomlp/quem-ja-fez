class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :show, :new, :create, :update]

  def index
    @events = Event.where(user: @user)
    @red_events = @user.events.where(color: "red").count
  end

  def show
    @event = Event.find(params[:id])
    @red_events = @user.events.where(color: "red").count

  end

  def new
    @event = Event.new

  end

  def edit
  end

  # When an undergraduate creates an event
  def create
    @event = Event.new(event_params)
    @event.user = @user
    @event.save
    # Cehck if there is any highschooler interested in talking to this undergraduate
    notify_highschooler if @user.interested_in_me.present?
  end

  def update
    @event.update(event_params)
    @red_events = @user.events.where(color: "red").count
    respond_to do |format|
        format.js
    end
  end

  def destroy
    @event.destroy
  end

  def success

  end

  #When highschooler confirm events
  def confirm
    @resume = Resume.find(params[:user_id])
    @user = @resume.user
    @events = @user.events.where(color: "red")

    # !- Stars -!
    @meetings = Meeting.where(undergraduate: @resume.user)
    @meeting = Meeting.new

    meetings_rated = 0
    total_rating = 0


    @meetings.each do |meeting|
      if meeting.rating.present?
        total_rating += meeting.rating
        meetings_rated += 1
      end
    end

    @avg_rating = meetings_rated.zero? ? nil : round_point5(total_rating.to_f / meetings_rated)
    # !- Stars -!
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def set_user
      @user = Resume.find(params[:user_id]).user
    end

    def event_params
      params.require(:event).permit(:title, :start, :end, :color, :user_id)
    end

    def notify_highschooler
      # O first pega o highschooler que mostrou interesse ha mais tempo: FIFO
      potential_meeting = @user.interested_in_me.first
      highschooler = potential_meeting.highschooler
      resume = potential_meeting.resume
      # Send email to highschooler
      UserMailer.notify_availability(resume, @user, highschooler).deliver
      # Depois de enviado e-mail podemos excluir a indicação de interesse
      potential_meeting.destroy
    end

    # !- Stars -!
    def round_point5(number)
      (number*2).round / 2.0
    end
    # !- Stars -!
end
