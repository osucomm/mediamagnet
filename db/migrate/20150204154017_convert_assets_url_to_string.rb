class ConvertAssetsUrlToString < ActiveRecord::Migration
  def change
    change_column :assets, :url, :text
  end
end
