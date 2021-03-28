class AddXpathToPolicies < ActiveRecord::Migration[5.1]
  def change
    add_column :policies, :xpath, :string
  end
end
