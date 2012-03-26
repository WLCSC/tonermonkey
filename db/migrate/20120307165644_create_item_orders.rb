class CreateItemOrders < ActiveRecord::Migration
  def change
    create_table :item_orders do |t|
      t.integer :order_id
      t.integer :item_id
      t.integer :change
      t.string :change_type

      t.timestamps
    end
  end
end
