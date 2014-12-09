class CreateItemLinks < ActiveRecord::Migration
  def change
    create_table :item_links do |t|
      t.references :item, index: true
      t.references :link, index: true

      t.timestamps
    end
  end
end
