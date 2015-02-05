class RemoveCategoryFromKeywords < ActiveRecord::Migration
  def change
    remove_column :keywords, :category, :integer
  end
end
