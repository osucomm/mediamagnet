class AddCategoryIdToKeywords < ActiveRecord::Migration
  def change
    add_reference :keywords, :category, index: true
  end
end
