class RemoveXpathFromVersions < ActiveRecord::Migration[5.1]
  def change
    remove_column :versions, :xpath, :string
  end
end
