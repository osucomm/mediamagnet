class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :type
      t.string :name
      t.text :description
      t.integer :entity_id
      t.boolean :primary
      t.string :service_identifier
      t.string :url

      t.timestamps
    end
  end
end
