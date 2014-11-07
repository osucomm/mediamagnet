class DropItemsTags < ActiveRecord::Migration
  def change
    drop_table :items_tags
  end
end
