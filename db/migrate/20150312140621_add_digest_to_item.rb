class AddDigestToItem < ActiveRecord::Migration
  def change
    add_column :items, :digest, :string
  end
end
