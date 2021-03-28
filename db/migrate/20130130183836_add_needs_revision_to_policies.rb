class AddNeedsRevisionToPolicies < ActiveRecord::Migration[5.1]
  def change
    add_column :policies, :needs_revision, :boolean
  end
end
