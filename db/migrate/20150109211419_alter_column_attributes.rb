class AlterColumnAttributes < ActiveRecord::Migration
  def change
    change_column_default :keyword_usages, :count, 0

    change_column_null :assets, :item_id, false
    change_column_null :assets, :url, false

    change_column_null :channels, :type, false
    change_column_null :channels, :name, false
    change_column_null :channels, :entity_id, false

    change_column_null :contacts, :contactable_id, false
    change_column_null :contacts, :contactable_type, false

    change_column_null :entities, :name, false

    change_column_null :entities_users, :entity_id, false
    change_column_null :entities_users, :user_id, false

    change_column_null :events, :item_id, false

    change_column_null :items, :channel_id, false

    change_column_null :items_links, :item_id, false
    change_column_null :items_links, :link_id, false

    change_column_null :keyword_usages, :keyword_id, false
    change_column_null :keyword_usages, :channel_id, false

    change_column_null :keywordings, :keywordable_type, false
    change_column_null :keywordings, :keywordable_id, false
    change_column_null :keywordings, :keyword_id, false

    change_column_null :keywords, :name, false

    change_column_null :links, :item_id, false
    change_column_null :links, :url, false

    change_column_null :manifests, :entity_id, false
    change_column_null :manifests, :url, false

    change_column_null :mappings, :mappable_id, false
    change_column_null :mappings, :mappable_type, false
    change_column_null :mappings, :tag_id, false
    change_column_null :mappings, :keyword_id, false

    change_column_null :taggings, :tag_id, false
    change_column_null :taggings, :item_id, false

    change_column_null :tags, :name, false

    change_column_null :tokens, :channel_id, false

    change_column_null :users, :email, false
  end
end
