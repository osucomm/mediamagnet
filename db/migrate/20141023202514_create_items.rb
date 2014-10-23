class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.integer :channel_id
      t.text :description
      t.string :link
      t.string :guid
      t.datetime :published_at
      t.datetime :fetched_at
      t.text :raw

      t.timestamps
    end
  end
end
