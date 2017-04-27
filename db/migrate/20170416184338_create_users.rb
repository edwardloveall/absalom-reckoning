class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.timestamps null: false
      t.string :email, null: false, index: true
      t.string :password_digest, null: false
    end
  end
end
