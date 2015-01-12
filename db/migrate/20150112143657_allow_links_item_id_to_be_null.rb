class AllowLinksItemIdToBeNull < ActiveRecord::Migration
  def change
    change_column_null :links, :item_id, true
  end
end
