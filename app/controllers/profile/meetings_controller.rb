class Profile::MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting, only: [:update]
  skip_before_action :verify_authenticity_token, only: :confirm_payment
  skip_before_action :authenticate_user!, only: :confirm_payment
  helper_method :index, :current_class?
  helper_method :update, :current_class?
  helper_method :new, :current_class?
  helper_method :edit, :current_class?
  helper_method :show, :current_class?

  def index
    @meetings_accepted = current_user.meetings_accepted
    @meetings_proposed = current_user.meetings_proposed
    # Future meetings
    @future_meetings_accepted = @meetings_accepted.where('end_time + INTERVAL \'5 min\' > ?', Time.current)
    @future_meetings_proposed = @meetings_proposed.where('end_time + INTERVAL \'5 min\' > ?', Time.current)
    @future_meetings = @future_meetings_accepted + @future_meetings_proposed
    @future_meetings.sort! { |a, b|  a.start_time <=> b.start_time }
    # Past meetings
    @past_meetings_accepted = @meetings_accepted.where('end_time + INTERVAL \'5 min\'  < ?', Time.current)
    @past_meetings_proposed = @meetings_proposed.where('end_time + INTERVAL \'5 min\'  < ?', Time.current)
    @past_meetings = @past_meetings_accepted + @past_meetings_proposed
    @past_meetings.sort! { |a, b|  b.start_time <=> a.start_time }
    # All the meetings together
    @meetings = @future_meetings + @past_meetings
  end

  def new
    @meeting = Meeting.new
  end

  def create
    events_id = params[:meeting][:event].split(" ")
    @resume = Resume.find(params[:meeting][:resume])
    events_id.each do |event|
      @event = Event.find(event)
      start_time = @event.start
      end_time = @event.end
      meeting = Meeting.create(start_time: start_time, end_time: end_time, highschooler: current_user, undergraduate: @resume.user, resume: @resume)
      @event.destroy
    end
    redirect_to profile_meetings_path
  end

  def update
    if @meeting.update(meeting_params)
      if request.xhr?
        render json: { ok: true }
      else
        redirect_to profile_meetings_path(anchor: "meeting#{@meeting.id}")
      end
    else
      redirect_to profile_meetings_path(anchor: "meeting#{@meeting.id}")
    end
  end

  # {
  #   "mc_gross"=>"898.00",
  #   "protection_eligibility"=>"Eligible",
  #   "address_status"=>"confirmed", "payer_id"=>"S8W2L2W3C98TS", "address_street"=>"1234 Rua Main", "payment_date"=>"08:51:39 Aug 23, 2017 PDT", "payment_status"=>"Completed", "charset"=>"windows-1252", "address_zip"=>"22021-001", "first_name"=>"test", "mc_fee"=>"30.93", "address_country_code"=>"BR", "address_name"=>"test buyer", "notify_version"=>"3.8", "custom"=>"{\"resume_id\":116,\"events_ids\":[549]}", "payer_status"=>"verified", "business"=>"quemjafez-facilitator@gmail.com", "address_country"=>"Brazil", "address_city"=>"Rio De Janeiro", "quantity"=>"1", "verify_sign"=>"Ar65LQ8D4i5231dnJnwTy8lT8UaGAs52nqTBpGY9nwlr3XEdAGKt-TsB", "payer_email"=>"quemjafez-buyer@gmail.com", "txn_id"=>"3CM950676U5037222", "payment_type"=>"instant", "last_name"=>"buyer", "address_state"=>"RJ", "receiver_email"=>"quemjafez-facilitator@gmail.com", "payment_fee"=>"", "receiver_id"=>"2FKKCG56CEC62", "txn_type"=>"web_accept", "item_name"=>"quemjafez", "mc_currency"=>"BRL", "item_number"=>"", "residence_country"=>"BR", "test_ipn"=>"1", "transaction_subject"=>"", "payment_gross"=>"", "shipping"=>"10.00", "ipn_track_id"=>"e7704aba95864", "controller"=>"profile/meetings", "action"=>"confirm_payment"}
  def confirm_payment
     payload = JSON.parse(params[:cm])

     resume = Resume.find(payload["resume_id"])
     events = Event.where(id: payload["events_ids"])
     highschooler = User.find(payload["highschooler_id"])

     events.each do |event|
      start_time = event.start
      end_time = event.end
      meeting = Meeting.create(start_time: start_time, end_time: end_time, highschooler: highschooler, undergraduate: resume.user, resume: resume)
      event.destroy
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:review_title, :review_content, :rating)
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
