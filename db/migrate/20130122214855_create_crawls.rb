class CreateCrawls < ActiveRecord::Migration[5.1]
  def change
    create_table :crawls do |t|
      t.integer :policy_id
      t.text :crawl

      t.timestamps
    end
  end
end
