class CreateVotes < ActiveRecord::Migration[8.1]
  def change
    create_table :votes do |t|
      t.references :issue, null: false, foreign_key: true
      t.string :participant_id
      t.string :participant_name
      t.string :value

      t.timestamps
    end
  end
end
