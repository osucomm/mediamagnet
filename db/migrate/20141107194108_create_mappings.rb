class CreateMappings < ActiveRecord::Migration
  def change
    create_table :mappings do |t|
      t.integer :mappable_id
      t.string :mappable_type
      t.integer :tag_id
      t.integer :keyword_id

      t.timestamps
    end
  end
end
