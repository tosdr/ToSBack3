class RenameCrawlInPolicy < ActiveRecord::Migration[5.1]
  def change
    rename_column :policies, :crawl, :detail
  end
end
