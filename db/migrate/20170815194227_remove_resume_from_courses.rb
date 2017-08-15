class RemoveResumeFromCourses < ActiveRecord::Migration[5.1]
  def change
    remove_reference :courses, :resume, foreign_key: true
  end
end
