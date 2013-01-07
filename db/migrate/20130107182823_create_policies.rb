class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.string :name
      t.string :url
      t.string :xpath
      t.string :lang
      t.text :crawl
      t.integer :site_id

      t.timestamps
    end
  end
end
