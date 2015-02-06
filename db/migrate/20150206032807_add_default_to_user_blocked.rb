class AddDefaultToUserBlocked < ActiveRecord::Migration
  def change
    change_column :users, :blocked, :boolean, :default => false
  end
end
