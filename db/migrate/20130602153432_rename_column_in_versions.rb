class RenameColumnInVersions < ActiveRecord::Migration
  def up
    rename_column :versions, :previous_crawl, :previous_policy
  end

  def down
    rename_column :versions, :previous_policy, :previous_crawl
  end
end
