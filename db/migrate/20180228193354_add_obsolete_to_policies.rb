class AddObsoleteToPolicies < ActiveRecord::Migration[5.1]
  def change
    add_column :policies, :obsolete, :boolean
  end
end
