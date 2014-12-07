class AddXpathAndTextToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :xpath, :string
    rename_column :versions, :previous_policy, :text
  end
end
