class CreatePasswordResets < ActiveRecord::Migration[5.1]
  def change
    create_table :password_resets do |t|
      t.timestamps
      t.belongs_to :user, index: true
      t.string :token
    end
  end
end
