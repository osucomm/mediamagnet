class ExpandStringColumnsForUnicode < ActiveRecord::Migration
  def change
    change_column :items, :title, :text, :limit => nil
    change_column :items, :source_identifier, :text, :limit => nil
    change_column :assets, :url, :text, :limit => nil, null: false
    change_column :channels, :url, :text, :limit => nil
    change_column :channels, :service_identifier, :text, :limit => nil
    change_column :links, :url, :text, :limit => nil, null: false
  end
end
