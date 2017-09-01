class CreatePotentialMeetings < ActiveRecord::Migration[5.1]
  def change
    create_table :potential_meetings do |t|
      t.boolean :interest

      t.timestamps
    end
  end
end
