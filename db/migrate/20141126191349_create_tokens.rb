class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :access_token
      t.string :refresh_token
      t.string :expires_at
      t.integer :channel_id

      t.timestamps
    end
  end
end
