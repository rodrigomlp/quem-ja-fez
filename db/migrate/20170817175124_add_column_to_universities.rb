class AddColumnToUniversities < ActiveRecord::Migration[5.1]
  def change
    add_column :universities, :email, :string
  end
end
