class AddCurrentEntityIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_entity_id, :integer
  end
end
