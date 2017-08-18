class AddEmailConfirmationTokenToResumes < ActiveRecord::Migration[5.1]
  def change
    add_column :resumes, :email_confirmation_token, :string
  end
end
