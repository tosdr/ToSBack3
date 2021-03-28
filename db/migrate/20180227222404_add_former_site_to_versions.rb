class AddFormerSiteToVersions < ActiveRecord::Migration[5.1]
  def change
    add_column :versions, :former_site, :string
  end
end
