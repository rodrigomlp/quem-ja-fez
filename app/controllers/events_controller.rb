class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @user = Resume.find(params[:user_id]).user
    # @events = Event.where(start: params[:start]..params[:end])
    @events = Event.where(user: @user)


  end

  def show
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
    @event.update(event_params)
  end

  def destroy
    # @event = Event.find(:id)
    @event.destroy
  end

  def success

  end

  def confirm
    @resume = Resume.find(params[:user_id])
    @user = @resume.user
    @events = @user.events.where(color: "red")
    @meeting = Meeting.new
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :start, :end, :color, :user_id)
    end

end
