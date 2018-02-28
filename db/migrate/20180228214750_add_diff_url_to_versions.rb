class AddDiffUrlToVersions < ActiveRecord::Migration[5.1]
  def change
    add_column :versions, :diff_url, :string
  end
end
