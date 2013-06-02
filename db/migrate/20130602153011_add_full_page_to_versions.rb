class AddFullPageToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :full_page, :text
  end
end
