class Meeting < ApplicationRecord

  belongs_to :undergraduate, class_name: 'User'
  belongs_to :highschooler, class_name: 'User'
  belongs_to :resume
  after_create :create_virtual_room

  def university_name
    resume.university.name
  end

  def course_name
    resume.course.name
  end

  def date_in_words
    if start_time.today?
      "Hoje"
    elsif start_time.to_date == Date.tomorrow
      "Amanhã"
    elsif start_time.to_date == Date.yesterday
      "Ontem"
    else
      start_time.strftime("%A, %d %b %y")
    end
  end

  def setup_time
    start_time - 10.minutes
  end

  def extra_time
    end_time + 5.minutes
  end

  def scheduled?
    Time.current < setup_time
  end

  def setting_up?
    Time.current >= setup_time && Time.current < start_time
  end

  def on_going?
    start_time <= Time.current && Time.current <= extra_time
  end

  def completed?
    extra_time < Time.current
  end

  def status
    return :scheduled if scheduled?
    return :setting_up if setting_up?
    return :on_going if on_going?
    return :completed if completed?
    fail "Invalid status"
  end

  private

  def create_virtual_room
    url_base = "https://appear.in/"
    self.virtual_room = url_base + SecureRandom.urlsafe_base64
    self.save!

  end

end
