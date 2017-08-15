class AddCourseToResumes < ActiveRecord::Migration[5.1]
  def change
    add_reference :resumes, :course, foreign_key: true
  end
end
