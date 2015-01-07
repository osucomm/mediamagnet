class UnPolymorphizeTaggings < ActiveRecord::Migration
  def change
    remove_column :taggings, :taggable_type, :string
    remove_column :taggings, :taggable_id, :integer
    add_column :taggings, :item_id, :integer
  end
end
