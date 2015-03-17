class CreateRefreshLocks < ActiveRecord::Migration
  def change
    create_table :refresh_locks do |t|
      t.references :channel, index: true
      t.integer :job_id

      t.timestamps null: false
    end
    add_foreign_key :refresh_locks, :channels
  end
end
