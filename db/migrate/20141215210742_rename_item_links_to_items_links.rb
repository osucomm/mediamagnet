class RenameItemLinksToItemsLinks < ActiveRecord::Migration
  def change
    rename_table :item_links, :items_links
  end
end
