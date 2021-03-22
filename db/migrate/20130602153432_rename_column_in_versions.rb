class RenameColumnInVersions < ActiveRecord::Migration[5.1]
  def up
    rename_column :versions, :previous_crawl, :previous_policy
  end

  def down
    rename_column :versions, :previous_policy, :previous_crawl
  end
end
