class CreateIssues < ActiveRecord::Migration[8.1]
  def change
    create_table :issues do |t|
      t.string :title
      t.integer :status
      t.text :description
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
