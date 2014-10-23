class CreateEntitiesUsers < ActiveRecord::Migration
  def change
    create_table :entities_users do |t|
      t.integer :entity_id
      t.integer :user_id

      t.timestamps
    end
  end
end
