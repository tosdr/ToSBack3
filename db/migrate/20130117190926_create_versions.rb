class CreateVersions < ActiveRecord::Migration[5.1]
  def change
    create_table :versions do |t|
      t.integer :policy_id
      t.text :previous_crawl

      t.timestamps
    end
  end
end
