class AddResumeToPotentialMeetings < ActiveRecord::Migration[5.1]
  def change
    add_reference :potential_meetings, :resume, foreign_key: true
  end
end
