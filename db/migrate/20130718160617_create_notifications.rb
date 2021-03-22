class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :site
      t.string :name

      t.timestamps
    end
  end
end
