class Profile::MeetingsController < ApplicationController
  before_action :authenticate_user!

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
end
