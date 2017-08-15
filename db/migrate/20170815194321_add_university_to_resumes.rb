class AddUniversityToResumes < ActiveRecord::Migration[5.1]
  def change
    add_reference :resumes, :university, foreign_key: true
  end
end
