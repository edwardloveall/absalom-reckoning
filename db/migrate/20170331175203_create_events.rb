class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.timestamps
      t.integer :occurred_on, index: true, null: false
      t.string :title, null: false
    end
  end
end
