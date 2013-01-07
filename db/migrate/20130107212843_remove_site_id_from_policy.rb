class RemoveSiteIdFromPolicy < ActiveRecord::Migration
  def up
    remove_column :policies, :site_id
  end

  def down
    add_column :policies, :site_id, :integer
  end
end
