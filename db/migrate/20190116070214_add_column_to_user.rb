class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string, unique: true, null: false
  end
end
