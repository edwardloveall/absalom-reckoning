class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps null: false
      t.string :email, null: false, index: true
      t.string :password_digest, null: false
    end
  end
end
