class RenameCrawlInCrawls < ActiveRecord::Migration
  def change
    rename_column :crawls, :crawl, :scrape
  end
end
