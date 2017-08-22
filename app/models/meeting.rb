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

  def send_emails
    @next_meetings = Meeting.where('start_time >= ? AND end_time <= ?', Date.tomorrow.beginning_of_day, Date.tomorrow.end_of_day)
    puts "The number of meetings in the next 24 hours is #{@next_meetings.size}"

    # Disparando email para os users das next meetings
    @next_meetings.each_with_index do |meeting, index|
      puts "Sending emails for the meeting #{index + 1}"
      UserMailer.remember_highschooler(meeting).deliver_now
      UserMailer.remember_undergraduate(meeting).deliver_now
    end
  end

  private

  def create_virtual_room
    url_base = "https://appear.in/"
    self.virtual_room = url_base + SecureRandom.urlsafe_base64
    self.save!

  end

end
