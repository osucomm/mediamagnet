class AddSourceIdentifierToItems < ActiveRecord::Migration
  def change
    add_column :items, :source_identifier, :string
  end
end
