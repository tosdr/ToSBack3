class AddPolicyToCrawls < ActiveRecord::Migration
  def change
    add_column :crawls, :policy, :text
  end
end
