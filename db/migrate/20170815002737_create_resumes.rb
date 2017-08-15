class CreateResumes < ActiveRecord::Migration[5.1]
  def change
    create_table :resumes do |t|
      t.string :school_email
      t.integer :relative_completion
      t.text :academic_description
      t.string :stance

      t.timestamps
    end
  end
end
