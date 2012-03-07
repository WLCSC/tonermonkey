class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :priority
      t.string :key
      t.integer :value
      t.integer :securable_id
      t.string :securable_type
      t.integer :principal_id

      t.timestamps
    end
  end
end
