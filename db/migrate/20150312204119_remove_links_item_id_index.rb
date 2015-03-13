class RemoveLinksItemIdIndex < ActiveRecord::Migration
  def up
    remove_foreign_key :links, :items
  end
end
