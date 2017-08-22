class Meeting < ApplicationRecord

  belongs_to :undergraduate, class_name: 'User'
  belongs_to :highschooler, class_name: 'User'
  belongs_to :resume
  after_create :create_virtual_room

  def university_name
    self.resume.university.name
  end

  def course_name
    self.resume.course.name
  end

  def date_in_words
    if self.start_time.today?
      "Hoje"
    elsif self.start_time.to_date == Date.tomorrow
      "Amanhã"
    elsif self.start_time.to_date == Date.yesterday
      "Ontem"
    else
      self.start_time.strftime("%A, %d %b %y")
    end
  end

  def setup_time
    start_time - 10.minutes
  end

  def chorinho
    end_time + 5.minutes
  end

  def scheduled?
    Time.now < setup_time
  end

  def setting_up?
    Time.now >= setup_time && Time.now < start_time
  end

  def on_going?
    start_time <= Time.now && Time.now <= chorinho
  end

  def completed?
    chorinho < Time.now
  end

  def status
    return :scheduled if scheduled?
    return :setting_up if setting_up?
    return :on_going? if on_going?
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
