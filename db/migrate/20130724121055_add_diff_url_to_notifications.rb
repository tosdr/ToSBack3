class AddDiffUrlToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :diff_url, :string
  end
end
