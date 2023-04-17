class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true, index: true
      t.string :session_token, null: false

      t.timestamps
    end
    add_index :users, [:username, :session_token], unique: true
  end
end
