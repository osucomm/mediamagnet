class AddApprovedToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :approved, :boolean, :default => false
    add_index :entities, :approved
  end
end
