class AddTypeToMappings < ActiveRecord::Migration
  def change
    add_column :mappings, :type, :string
  end
end
