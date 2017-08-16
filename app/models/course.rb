class Course < ApplicationRecord
  has_many :resumes

  def to_s
    name
  end
end
