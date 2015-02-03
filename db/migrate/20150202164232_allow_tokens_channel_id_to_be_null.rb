class AllowTokensChannelIdToBeNull < ActiveRecord::Migration
  def change
    change_column_null :tokens, :channel_id, true
  end
end
