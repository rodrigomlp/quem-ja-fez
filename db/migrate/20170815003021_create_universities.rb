class CreateUniversities < ActiveRecord::Migration[5.1]
  def change
    create_table :universities do |t|
      t.string :name
      t.references :resume, foreign_key: true

      t.timestamps
    end
  end
end
