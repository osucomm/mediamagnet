class DropOldTables < ActiveRecord::Migration
  def change
    drop_table :entities_keywords
    drop_table :channels_keywords
    drop_table :channels_tags
  end
end
