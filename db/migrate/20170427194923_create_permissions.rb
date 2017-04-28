class CreatePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions do |t|
      t.timestamps null: false
      t.belongs_to :calendar
      t.belongs_to :user
      t.string :level, default: 'viewer'
    end
  end
end
