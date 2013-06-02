class ChangeTableCrawls < ActiveRecord::Migration
  def up
    change_table :crawls do |t|
      t.rename :scrape, :full_page
    end
  end

  def down
    change_table :crawls do |t|
      t.rename :full_page, :scrape
    end
  end
end
