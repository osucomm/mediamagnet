class CreateChannelsKeywords < ActiveRecord::Migration
  def change
    create_table :channels_keywords do |t|
      t.integer :channel_id
      t.integer :keyword_id
    end
  end
end
