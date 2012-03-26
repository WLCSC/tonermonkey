class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :item_id
      t.integer :store_id
      t.integer :count

      t.timestamps
    end
  end
end
