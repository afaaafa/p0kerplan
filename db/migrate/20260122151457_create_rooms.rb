class CreateRooms < ActiveRecord::Migration[8.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :slug
      t.string :admin_token

      t.timestamps
    end
    add_index :rooms, :slug
  end
end
