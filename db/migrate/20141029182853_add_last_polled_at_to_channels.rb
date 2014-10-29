class AddLastPolledAtToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :last_polled_at, :datetime
  end
end
