class ChangeTimesToDatetimesFromMeetings < ActiveRecord::Migration[5.1]
  def change
    remove_column :meetings, :start_time, :time
    remove_column :meetings, :end_time, :time
    add_column :meetings, :start_time, :datetime
    add_column :meetings, :end_time, :datetime
  end
end
