class RenameCrawlInPolicy < ActiveRecord::Migration
  def change
    rename_column :policies, :crawl, :detail
  end
end
