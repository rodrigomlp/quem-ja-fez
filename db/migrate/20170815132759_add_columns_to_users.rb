class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :birth_date, :date
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :undergraduate, :boolean
    add_column :users, :personal_description, :text
  end
end
