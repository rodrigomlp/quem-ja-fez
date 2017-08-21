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

  private

  def create_virtual_room
    url_base = "https://appear.in/"
    self.virtual_room = url_base + SecureRandom.urlsafe_base64
    self.save!

  end

end
