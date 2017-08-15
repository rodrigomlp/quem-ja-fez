class AddColumnsToMeetings < ActiveRecord::Migration[5.1]
  def change
    add_column :meetings, :undergraduate_id, :integer
    add_column :meetings, :highschooler_id, :integer

    add_foreign_key :meetings, :users, column: :undergraduate_id
    add_foreign_key :meetings, :users, column: :highschooler_id
  end
end
