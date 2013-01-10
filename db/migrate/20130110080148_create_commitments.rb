class CreateCommitments < ActiveRecord::Migration
  def change
    create_table :commitments do |t|
      t.integer :policy_id
      t.integer :site_id

      t.timestamps
    end
  end
end
