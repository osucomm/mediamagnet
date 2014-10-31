class RemoveFetchedAtFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :fetched_at, :datetime
  end
end
