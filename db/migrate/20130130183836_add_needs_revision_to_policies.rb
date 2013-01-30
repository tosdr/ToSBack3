class AddNeedsRevisionToPolicies < ActiveRecord::Migration
  def change
    add_column :policies, :needs_revision, :boolean
  end
end
