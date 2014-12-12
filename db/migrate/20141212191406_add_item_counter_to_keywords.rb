class AddItemCounterToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :item_counter, :integer
  end
end
