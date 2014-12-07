class RemoveXpathAndDetailFromPolicies < ActiveRecord::Migration
  def up
    remove_column :policies, :xpath
    remove_column :policies, :detail
  end

  def down
    add_column :policies, :detail, :text
    add_column :policies, :xpath, :string
  end
end
