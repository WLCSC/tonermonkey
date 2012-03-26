class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :short
      t.string :barcode

      t.timestamps
    end
  end
end
