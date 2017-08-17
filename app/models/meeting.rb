class Meeting < ApplicationRecord

  belongs_to :undergraduate, class_name: 'User'
  belongs_to :highschooler, class_name: 'User'
  belongs_to :resume

  def university_name
    self.resume.university.name
  end

  def course_name
    self.resume.course.name
  end

end
