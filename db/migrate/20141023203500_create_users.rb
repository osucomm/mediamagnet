class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :fullname
      t.datetime :last_sign_in_at

      t.timestamps
    end
  end
end
