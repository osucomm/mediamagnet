class AddJobIdToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :job_id, :string
  end
end
