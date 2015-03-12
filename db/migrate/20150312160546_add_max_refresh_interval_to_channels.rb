class AddMaxRefreshIntervalToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :max_refresh_interval, :integer, default: 300
  end
end
