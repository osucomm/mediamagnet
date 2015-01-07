class RemoveKeywordIdFromTaggings < ActiveRecord::Migration
  def change
    remove_column :taggings, :keyword_id, :integer
  end
end
