class DeleteStanceFromResumes < ActiveRecord::Migration[5.1]
  def change
    remove_column :resumes, :stance
  end
end
