class AddAvatarUrlToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :avatar_url, :text
  end
end
