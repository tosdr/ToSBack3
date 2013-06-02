class RenameColumnInCrawls < ActiveRecord::Migration
  def up
    rename_column :crawls, :policy, :crawled_policy
  end

  def down
    rename_column :crawls, :crawled_policy, :policy
  end
end
