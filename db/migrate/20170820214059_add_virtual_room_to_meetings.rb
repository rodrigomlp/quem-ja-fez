class AddVirtualRoomToMeetings < ActiveRecord::Migration[5.1]
  def change
    add_column :meetings, :virtual_room, :string
  end
end
