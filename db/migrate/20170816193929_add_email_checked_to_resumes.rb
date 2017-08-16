class AddEmailCheckedToResumes < ActiveRecord::Migration[5.1]
  def change
    add_column :resumes, :email_checked, :boolean
  end
end
