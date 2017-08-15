class AlterDefaultUndergraduateToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_default :users, :undergraduate, from: nil, to: false
  end
end
