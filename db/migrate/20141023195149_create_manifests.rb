class CreateManifests < ActiveRecord::Migration
  def change
    create_table :manifests do |t|
      t.integer :entity_id
      t.string :url
      t.text :last_response
      t.datetime :succeded_at
      t.datetime :fetched_at

      t.timestamps
    end
  end
end
