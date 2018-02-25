class AddXpathAndTextToVersions < ActiveRecord::Migration[4.2]
  def change
    add_column :versions, :xpath, :string
    rename_column :versions, :previous_policy, :text
  end
end
