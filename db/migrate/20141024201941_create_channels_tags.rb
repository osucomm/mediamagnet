class CreateChannelsTags < ActiveRecord::Migration
  def change
    create_table :channels_tags do |t|
      t.integer :channel_id
      t.integer :tag_id
    end
  end
end
