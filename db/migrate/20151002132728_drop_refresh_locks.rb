class DropRefreshLocks < ActiveRecord::Migration
  def change
    drop_table :refresh_locks
  end
end
