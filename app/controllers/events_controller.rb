class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @user = Resume.find(params[:user_id]).user
    # @events = Event.where(start: params[:start]..params[:end])
    @events = Event.where(user: @user)
    @red_events = @user.events.where(color: "red").count
  end

  def show
    @user = Resume.find(params[:user_id]).user
    @event = Event.find(params[:id])
    @red_events = @user.events.where(color: "red").count

  end

  def new
    @event = Event.new
    @user = Resume.find(params[:user_id]).user

  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.user = Resume.find(params[:user_id]).user
    @event.save
  end

  def update
    @user = Resume.find(params[:user_id]).user
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

    def event_params
      params.require(:event).permit(:title, :start, :end, :color, :user_id)
    end

    private

    # !- Stars -!
    def round_point5(number)
      (number*2).round / 2.0
    end
    # !- Stars -!
end
