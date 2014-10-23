class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :organization
      t.string :url
      t.string :phone
      t.string :email
      t.integer :contactable_id
      t.string :contactable_type

      t.timestamps
    end
  end
end
