class AddParentIdToEntities < ActiveRecord::Migration
  def change
    add_reference :entities, :parent, index: true
  end
end
