class DropTableUsers < ActiveRecord::Migration[5.1]
  def change
    drop_table(:users) do |t|
      t.string "name"
      t.string "email"
      t.boolean "admin"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "password_digest"
      t.index ["email"], name: "index_users_on_email", unique: true
    end
  end
end
