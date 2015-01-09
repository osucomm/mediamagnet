class CreateIndexes < ActiveRecord::Migration
  def change
    add_index :assets, :item_id
    add_foreign_key :assets, :items

    add_index :channels, :entity_id
    add_foreign_key :channels, :entities

    add_index :channels, :type

    add_index :contacts, [:contactable_id, :contactable_type]

    add_index :entities_users, :entity_id
    add_index :entities_users, :user_id
    add_foreign_key :entities_users, :entities
    add_foreign_key :entities_users, :users

    add_index :events, :item_id
    add_foreign_key :events, :items
    add_index :events, :location_id
    add_foreign_key :events, :locations
    add_index :events, :start_date
    add_index :events, :end_date

    add_index :items, :channel_id
    add_foreign_key :items, :channels
    add_index :items, :published_at

    add_foreign_key :items_links, :items
    add_foreign_key :items_links, :links

    add_index :keyword_usages, :count

    add_index :keywordings, [:keywordable_id, :keywordable_type]
    add_index :keywordings, :keyword_id
    add_foreign_key :keywordings, :keywords

    add_index :keywords, :name
    remove_column :keywords, :item_counter

    add_index :links, :item_id
    add_foreign_key :links, :items

    add_index :manifests, :entity_id
    add_foreign_key :manifests, :entities

    add_index :mappings, [:mappable_id, :mappable_type]
    add_index :mappings, :tag_id
    add_foreign_key :mappings, :tags
    add_index :mappings, :keyword_id
    add_foreign_key :mappings, :keywords
    add_index :mappings, :type

    add_index :taggings, :tag_id
    add_foreign_key :taggings, :tags
    add_index :taggings, :item_id
    add_foreign_key :taggings, :items

    add_index :tokens, :channel_id
    add_foreign_key :tokens, :channels

    add_index :users, :username
    add_index :users, :admin
    
  end
end
