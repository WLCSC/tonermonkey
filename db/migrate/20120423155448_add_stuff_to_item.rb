class AddStuffToItem < ActiveRecord::Migration
  def change
    add_column :items, :target, :integer

    add_column :items, :unsafe, :integer

  end
end
