class CreateItemsKeywords < ActiveRecord::Migration
  def change
    create_table :items_keywords do |t|
      t.integer :item_id
      t.integer :keyword_id
    end
  end
end
