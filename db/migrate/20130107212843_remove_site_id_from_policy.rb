class RemoveSiteIdFromPolicy < ActiveRecord::Migration[5.1]
  def up
    remove_column :policies, :site_id
  end

  def down
    add_column :policies, :site_id, :integer
  end
end
