class DropItemsKeywords < ActiveRecord::Migration
  def change
    drop_table :items_keywords
  end
end
