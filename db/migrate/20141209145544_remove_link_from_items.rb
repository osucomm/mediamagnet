class RemoveLinkFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :link, :string
  end
end
