class CreateParticipants < ActiveRecord::Migration[8.1]
  def change
    create_table :participants do |t|
      t.string :name
      t.string :session_id
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
