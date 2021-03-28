class AddFullPageToVersions < ActiveRecord::Migration[5.1]
  def change
    add_column :versions, :full_page, :text
  end
end
