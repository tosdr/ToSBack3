class AddPolicyToCrawls < ActiveRecord::Migration[5.1]
  def change
    add_column :crawls, :policy, :text
  end
end
