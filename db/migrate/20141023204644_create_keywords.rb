class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :name
      t.string :display_name
      t.text :description
      t.integer :category

      t.timestamps
    end
  end
end
