class RemoveLinksItemIdIndex < ActiveRecord::Migration
  def up
    remove_index :links, column: :item_id
  end
end
