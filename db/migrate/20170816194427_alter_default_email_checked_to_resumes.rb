class AlterDefaultEmailCheckedToResumes < ActiveRecord::Migration[5.1]
  def change
        change_column_default :resumes, :email_checked, from: nil, to: false
  end
end
