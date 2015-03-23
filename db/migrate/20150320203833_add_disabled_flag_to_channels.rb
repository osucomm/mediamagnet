class AddDisabledFlagToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :disabled, :boolean
  end
end
