class CreateMeetings < ActiveRecord::Migration[5.1]
  def change
    create_table :meetings do |t|
      t.time :start_time
      t.time :end_time
      t.text :review_title
      t.text :review_content
      t.integer :rating

      t.timestamps
    end
  end
end
