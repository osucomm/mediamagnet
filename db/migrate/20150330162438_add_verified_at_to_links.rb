class AddVerifiedAtToLinks < ActiveRecord::Migration
  def change
    add_column :links, :last_verified_at, :datetime
  end
end
