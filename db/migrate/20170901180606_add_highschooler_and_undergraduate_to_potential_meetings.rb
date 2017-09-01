class AddHighschoolerAndUndergraduateToPotentialMeetings < ActiveRecord::Migration[5.1]
  def change
    add_column :potential_meetings, :undergraduate_id, :integer
    add_column :potential_meetings, :highschooler_id, :integer

    add_foreign_key :potential_meetings, :users, column: :undergraduate_id
    add_foreign_key :potential_meetings, :users, column: :highschooler_id
  end
end
