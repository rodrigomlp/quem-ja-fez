class RemoveInterestFromPotentialMeetings < ActiveRecord::Migration[5.1]
  def change
    remove_column :potential_meetings, :interest
  end
end
