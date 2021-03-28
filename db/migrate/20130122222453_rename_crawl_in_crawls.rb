class RenameCrawlInCrawls < ActiveRecord::Migration[5.1]
  def change
    rename_column :crawls, :crawl, :scrape
  end
end
