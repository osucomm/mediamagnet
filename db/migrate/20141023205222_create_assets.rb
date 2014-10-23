class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :item_id
      t.string :mime
      t.string :url
      t.string :title
      t.string :alt

      t.timestamps
    end
  end
end
