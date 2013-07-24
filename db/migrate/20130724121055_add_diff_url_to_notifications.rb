class AddDiffUrlToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :diff_url, :string
  end
end
