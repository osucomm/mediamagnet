class CreateEntitiesKeywords < ActiveRecord::Migration
  def change
    create_table :entities_keywords do |t|
      t.integer :entity_id
      t.integer :keyword_id
    end
  end
end
